enum DeployTarget { Development, Production }

const _isProduction = bool.fromEnvironment('dart.vm.product');
const _backendURI = String.fromEnvironment("BACKEND_URI");

class Env {
  DeployTarget _deployTarget;
  String _ticTacToeBattleBackendURI;

  get deployTarget => _deployTarget;

  get backendURI => _ticTacToeBattleBackendURI;

  Env()
      : _deployTarget = _isProduction ? DeployTarget.Production : DeployTarget.Development,
        _ticTacToeBattleBackendURI = _backendURI;
}
