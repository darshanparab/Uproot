﻿Add-WMIEventFilter -ComputerName 'localhost' -Name ShadowCopyCreation -Query "SELECT * FROM __InstanceCreationEvent WITHIN 10 WHERE TargetInstance ISA 'Win32_ShadowCopy'"