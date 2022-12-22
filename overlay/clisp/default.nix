final: prev: {
      clisp = prev.clisp.override {
        # On newer readline8 fails as:
        #  #<FOREIGN-VARIABLE "rl_readline_state" #x...>
        #   does not have the required size or alignment
        readline = final.pkgs.readline6;
      };
}
