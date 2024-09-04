# KMonad configuration

## .rc Installation instructions

Symlink the service file to /etc, enable and start the systemd service.
```bash
sudo ln -s ~/.rc/config/kmonad/kmonad.service /etc/systemd/system/kmonad.service
systemctl enable kmonad
systemctl start kmonad
```

## Upstream Documentation
Content taken from [KMonad FAQ](https://github.com/kmonad/kmonad/blob/master/doc/faq.md).

### Q: How do I get Uinput permissions?

A: In Linux KMonad needs to be able to access the `input` and `uinput` subsystem to inject
events. To do this, your user needs to have permissions. To achieve this, take
the following steps:

If the `uinput` group does not exist, create a new group with:

1. Make sure the `uinput` group exists

```bash
sudo groupadd uinput
```

2. Add your user to the `input` and the `uinput` group:
```bash
sudo usermod -aG input username
sudo usermod -aG uinput username
```

Make sure that it's effective by running `groups`. You might have to logout and login.

3. Make sure the uinput device file has the right permissions:
Add a udev rule (in either `/etc/udev/rules.d` or `/lib/udev/rules.d`) with the
following content:
```bash
KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
```

4. Make sure the `uinput` drivers are loaded.
You will probably have to run this command whenever you start `kmonad` for the first time.
```bash
sudo modprobe uinput
```


### Q: How do I know which event-file corresponds to my keyboard?

A: By far the best solution is to use the keyboard devices listed under `/dev/input/by-id`. In some case, you could also try `/dev/input/by-path`.
If you can't figure out which file just by the filenames, the `evtest` program is very helpful.
