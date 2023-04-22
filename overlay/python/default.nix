final: prev: {
  python3Packages = prev.python3Packages.override {
    overrides = self: super:
      {
        whatthepatch = with super.pkgs.python3Packages;
          buildPythonPackage rec {
            pname = "whatthepatch";
            version = "1.0.2";
            src = fetchPypi {
              inherit version pname;
              sha256 = "sha256-xUDqWRc+CikeGcdC3YtAbFbivgOaYA7bfG/Drku9+p8=";
            };

            checkInputs = [
              pytest
            ];

            propagatedBuildInputs = [

            ];
            # doCheck = false;

          };

        python-lsp-server = with super.pkgs.python3Packages;
          buildPythonPackage rec {
            pname = "python-lsp-server";
            version = "1.5.0";
            src = fetchPypi {
              inherit version pname;
              sha256 = "sha256-5cCUwZklAionxAaPQUsrtlMkP4+w12jjlzUonXqJOA0=";
            };

            checkInputs = [
              autopep8
              flaky
              pycodestyle
              pydocstyle
              pyflakes
              pylint
              pytest
              rope
              self.whatthepatch
              yapf
            ];

            propagatedBuildInputs = [
              jedi
              pip
              pluggy
              python-lsp-jsonrpc
              setuptools
              twine
              ujson
              wheel
            ];
          };

        python-lsp-black = with super.pkgs.python3Packages;
          buildPythonPackage rec {
            pname = "python-lsp-black";
            version = "1.2.1";

            checkInputs = [
              pytest
            ];

            buildInputs = [
              black
              self.python-lsp-server
            ];

            # version is 0.0.0 for some reasons
            patchPhase = ''
              sed -i 's/python-lsp-server>=1.4.0/python-lsp-server/g' setup.cfg
            '';

            src = super.pkgs.python3Packages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-1+rqsqN36WqCzCav4vjy4c98bq79zeqwJjQ+LlWdzOk=";
            };
          };

        python-lsp-isort = with super.pkgs.python3Packages;
          buildPythonPackage rec {
            pname = "pyls-isort";
            version = "0.2.2";

            checkInputs = [
              pytest
            ];

            buildInputs = [
              isort
              self.python-lsp-server
            ];

            # version is 0.0.0 for some reasons
            patchPhase = ''
              sed -i 's/python-lsp-server>=1.4.0/python-lsp-server/g' setup.cfg
            '';

            src = super.pkgs.python3Packages.fetchPypi {
              inherit pname version;
              sha256 = "sha256-IZK9IgPbAEWfhesylSH+ulivYwddLdEKBRpOzNAAu6A=";
            };
          };
      };
  };
}
