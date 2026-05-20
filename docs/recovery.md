# LEMMON-714: Gold Master Recovery Protocol

This document is the absolute source of truth for rebuilding the Lemmon-714 architecture from bare metal. If the host machine is wiped, follow this strict execution order to restore the exact development chassis.

---

## Phase 1: The Windows Host Preparation

Before the Linux engine can be built, the host hardware must be configured.

### 1. Clone the Vault

Pull this repository to a temporary location on the Windows host.

### 2. Execute the Payload

Open PowerShell as Administrator and run the host bootstrapper:

```powershell
.\os\windows\bootstrap.ps1
```

### 3. Deploy Windows Dotfiles

Map the Windows Terminal and PowerShell profiles to the system:

```powershell
.\os\windows\sync.ps1
```

### 4. Reboot the Machine

This is critical to ensure the JetBrains Mono font renders correctly in all terminal instances.

---

## Phase 2: The Linux Engine (WSL)

Once the host is stabilized and Windows Terminal is active, deploy the Ubuntu baseline.

### 1. Install WSL (If Bare Metal)

```powershell
wsl --install -d Ubuntu
```

### 2. Inject the Linux BIOS

Copy the isolated system configuration to the Ubuntu root and restart WSL:

```bash
sudo cp os/linux/wsl.conf /etc/wsl.conf
wsl.exe --shutdown
```

### 3. Execute the Linux Payload

Boot back into Ubuntu and run the deployment engine:

```bash
./os/linux/bootstrap.sh
```

---

## Phase 3: The Architecture Symlink

With both OS environments fully populated with their package matrices, orchestrate the final symlink layer.

### Run the Master Makefile

From the root of this repository inside WSL, execute:

```bash
make install
```

This command leverages GNU Stow to perfectly map the `.bashrc`, `.config` matrices, and runtime variables directly into the Linux home directory.

---

## Phase 4: Diagnostic Validation

Ensure the deployment was mathematically perfect.

### Run the Doctor

```bash
./scripts/doctor.sh
```

If all checks pass (`Node`, `Python`, `Git`, `Stow`, `Starship`, `Fastfetch`), the Lemmon-714 chassis is fully operational.