/// Contrato base para todos os use cases.
/// [T] é o que o use case devolve; [Params] são os dados de entrada.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

/// Usar quando o use case não precisa de parâmetros.
class NoParams {
  const NoParams();
}