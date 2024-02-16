[
  (final: prev:
{
#  python3Packages = import ./python;
  vulkan-utility-libraries = prev.vulkan-utility-libraries.overrideAttrs (old: {
    version = "1.3.268";
    src = final.fetchFromGitHub {
      owner = "KhronosGroup";
      repo = "Vulkan-Utility-Libraries";
      rev = "v1.3.268";
      hash = "sha256-O1agpzZpXiQZFYx1jPosIhxJovZtfZSLBNFj1LVB1VI=";
    };
  });
})
]
