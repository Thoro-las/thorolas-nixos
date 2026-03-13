final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (python-final: python-prev: {
      jupynium = python-final.buildPythonPackage rec {
        pname = "jupynium";
        version = "0.2.5";
        format = "pyproject";

        src = final.fetchFromGitHub {
          owner = "kiyoon";
          repo = "jupynium.nvim";
          rev = "v${version}";
          hash = "sha256-ukVwvvE40KARzukadaB4xLsvcMc0quKEb72GfWmUaAI=";
        };

        nativeBuildInputs = with python-final; [
          setuptools
          wheel
          setuptools-scm
        ];

        propagatedBuildInputs = with python-final; [
          pynvim
          coloredlogs
          verboselogs
          selenium
          psutil
          persist-queue
          gitpython
          platformdirs
          websocket-client
          requests
          nest-asyncio
        ];

        doCheck = false;
      };
    })
  ];
}
