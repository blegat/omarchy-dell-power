# Dell Power for Omarchy

An Omarchy shell plugin that extends the built-in power panel with Dell battery charging controls.

It keeps the standard battery information and power-profile picker, and adds controls for Dell's charging modes:

| Linux kernel | Dell firmware | Description |
|---|---|---|
| `Trickle` | Primarily AC | Limits charging to reduce battery wear when the laptop spends most of its time plugged in. |
| `Fast` | ExpressCharge | Charges the battery faster; frequent use may age the battery sooner. |
| `Standard` | Standard | Charges to 100% at a moderate rate for mixed battery and plugged-in use. |
| `Adaptive` | Adaptive | Learns typical usage patterns and adjusts charging automatically. |
| `Custom` | Custom | Starts and stops charging at user-selected thresholds. |

Hover a charging mode or percentage button for a short explanation.

## Requirements

- Omarchy with the Quickshell desktop
- A Dell laptop supported by the Linux `dell_laptop` driver
- `/sys/class/power_supply/BAT0/charge_types`
- `/sys/class/power_supply/BAT0/charge_control_start_threshold`
- `/sys/class/power_supply/BAT0/charge_control_end_threshold`

The plugin hides the Dell controls when these interfaces are unavailable.

## Install

Add and enable the plugin:

```bash
omarchy plugin add https://github.com/blegat/omarchy-dell-power.git --enable
```

Install its small privileged helper from a terminal:

```bash
~/.config/omarchy/plugins/dell.power/install-helper.sh
```

The second command uses `sudo` to install a root-owned helper at `/usr/local/bin/omarchy-dell-battery-charge`. Changing a firmware charging setting from the graphical panel then opens a `pkexec` authentication prompt.

## Update

```bash
omarchy plugin update dell.power
~/.config/omarchy/plugins/dell.power/install-helper.sh
```

Run the helper installer again after an update so its root-owned copy matches the plugin.

## Remove

Remove the privileged helper first, then the plugin:

```bash
~/.config/omarchy/plugins/dell.power/uninstall-helper.sh
omarchy plugin remove dell.power
```

Removing the plugin restores Omarchy's built-in power widget because this plugin declares that it was cloned from `omarchy.power`.

## Security

Omarchy plugins execute as unsandboxed user code. This plugin invokes only the installed, root-owned helper through `pkexec`. The helper accepts an allowlisted charging mode or validated numeric thresholds and writes only the fixed Dell battery sysfs controls.

Review `dell-battery-charge` before installing it.

## License

MIT. The power panel and model began as modifications of Omarchy's built-in power plugin.
