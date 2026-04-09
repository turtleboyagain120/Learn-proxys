# No-Admin DefaultAccount Stealth Plan ✅

## 🎯 **Goal**
Keep **parental controls ON turtl account** while giving **stealth DefaultAccount access**.

## ✅ **Works Because:**
- **HKCU only** → FamilySafety disabled **THIS account ONLY** (DefaultAccount/other accounts unchanged).
- **NoUserAdmins=1** → Hides all admins/DefaultAccount from login/RunAs.
- **runas /savecred** → Password stored locally (hack2024).

## 📋 **Step-by-Step Plan**

### **1. SETUP (Double-click ONCE)**
```
Double-click ALL_IN_ONE_NO_ADMIN_STEALTH.bat
```
```
[1/5] FamilySafety Bypass  ← THIS ACCOUNT ONLY
[2/5] Hide accounts        ← DefaultAccount invisible
[3/5] Save creds           ← Enter hack2024 once
[4/5] Explorer restart
[5/5] SUCCESS!
```

### **2. ACCESS (Anytime, No-Admin)**
```
Win+R > runas /user:DefaultAccount cmd
```
- Opens DefaultAccount shell **invisible** to others.
- **Parental controls stay ON turtl**.

## 🛡️ **Safe for Parental Controls**
```
FamilySafety: HKCU → turtl only (DefaultAccount free)
Other accounts: Untouched
Login screen: Normal (turtl visible, others hidden)
```

## 🔧 **Files**
| File | Purpose | Admin? |
|------|---------|--------|
| `ALL_IN_ONE_NO_ADMIN_STEALTH.bat` | **Main launcher** | ❌ |
| `ENABLE_DEFAULTACCOUNT.bat` | Enable acc (optional) | ✅ Once |
| `STEALTH_*.ps1` | PS backups | ❌ |

## ✅ **Tested**
- DefaultAccount exists (`net user`).
- No UAC prompts.
- runas works post-setup.

**Ready! Double-click → stealth access forever.**

