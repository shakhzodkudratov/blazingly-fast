{ globalib, ... }:
{
  imports = (globalib.folderNixList ./.) ++ (globalib.folderNixList ../common);
}
