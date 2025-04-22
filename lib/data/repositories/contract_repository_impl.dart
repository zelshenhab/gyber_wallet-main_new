import 'dart:async';
import 'package:crypto_wallet/data/repositories/repositories.dart';
import 'package:crypto_wallet/domain/repositories/repositories.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

class ContractRepositoryImpl extends ContractRepository {
  ContractRepositoryImpl({
    Web3Client? web3client,
    PhraseRepository? phraseRepository,
  })  : _web3client =
            web3client ?? Web3Client(dotenv.env['ALCHEMY_API']!, http.Client()),
        _phraseRepository = phraseRepository ?? PhraseRepositoryImpl() {
    initialize();
  }

  final Web3Client _web3client;
  final PhraseRepository _phraseRepository;
  late ContractAbi? _erc20Abi;
  final StreamController<EtherAmount> _ethBalanceController =
      StreamController<EtherAmount>();

  @override
  Future<void> initialize() async {
    final erc20AbiString =
        await rootBundle.loadString('assets/abi/ERC-20.json');
    _erc20Abi = ContractAbi.fromJson(erc20AbiString, 'ERC20');
  }

  Future<EtherAmount> _getEth(String publicKey) async {
    if (publicKey.isEmpty ||
        !publicKey.startsWith('0x') ||
        publicKey.length != 42) {
      if (kDebugMode) {
        print('🚫 Invalid wallet address: $publicKey');
      }
      return EtherAmount.inWei(BigInt.zero);
    }

    final ethAddress = EthereumAddress.fromHex(publicKey);
    return await _web3client.getBalance(ethAddress);
  }

  @override
  Stream<EtherAmount> getEthBalance(String publicKey) async* {
    if (publicKey.isEmpty ||
        !publicKey.startsWith('0x') ||
        publicKey.length != 42) {
      if (kDebugMode) {
        print('🚫 Invalid or empty address in getEthBalance');
      }
      yield EtherAmount.inWei(BigInt.zero);
      return;
    }

    yield* Stream<Future<EtherAmount>>.periodic(
      const Duration(seconds: 5),
      (_) => _getEth(publicKey),
    ).asyncMap((event) async => event);
  }

  @override
  Future<String> getTokenBalance(
    String contractAddress,
    String publicKey,
  ) async {
    final contract =
        DeployedContract(_erc20Abi!, EthereumAddress.fromHex(contractAddress));
    final ethAddress = EthereumAddress.fromHex(publicKey);
    final response = await _web3client.call(
      contract: contract,
      function: contract.function('balanceOf'),
      params: <dynamic>[ethAddress],
    );
    return response.first.toString();
  }

  @override
  Future<String> getTokenDecimal(String contractAddress) async {
    final contract =
        DeployedContract(_erc20Abi!, EthereumAddress.fromHex(contractAddress));
    final response = await _web3client.call(
      contract: contract,
      function: contract.function('decimals'),
      params: [],
    );
    return response.first.toString();
  }

  @override
  Future<String> getTokenSymbol(String contractAddress) async {
    final contract =
        DeployedContract(_erc20Abi!, EthereumAddress.fromHex(contractAddress));
    final response = await _web3client.call(
      contract: contract,
      function: contract.function('symbol'),
      params: [],
    );
    return response.first as String;
  }

  @override
  Future<String> sendEth({
    required String privateKey,
    required String to,
    required BigInt amount,
  }) async {
    final ethAddress = await _phraseRepository.generatePublicKey(privateKey);
    final credentials = EthPrivateKey.fromHex(privateKey);
    final toAddress = EthereumAddress.fromHex(to);
    final transaction = Transaction(
      from: ethAddress,
      to: toAddress,
      value: EtherAmount.inWei(amount),
    );
    return await _web3client.sendTransaction(credentials, transaction,
        chainId: 3);
  }

  @override
  Future<List> getTransactions(String contractAddress) {
    throw UnimplementedError();
  }

  @override
  void dispose() {
    _web3client.dispose();
    _ethBalanceController.close();
  }
}
