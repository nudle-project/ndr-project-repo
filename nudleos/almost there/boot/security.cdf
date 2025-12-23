[CatalogHeader]
Name=security.cat
PublicRevision=0x0000001
DesktopVersion=0x603
[SourceFiles]
; This section lists the files NudleOS needs for UEFI boot.
; Replace the paths below with the actual locations of your compiled files.

<hash>NudleBoot.efi=.\NudleBoot.efi
<hash>NudleNetwork.sys=.\NudleNetwork.sys
<hash>NudleRuntime.dll=.\NudleRuntime.dll

[CatalogFiles]
; This tells the tool to create a signature for each file listed above.
<hash>NudleBoot.efi
<hash>NudleNetwork.sys
<hash>NudleRuntime.dll