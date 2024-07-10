# Installing Deepin WeChat and QQ IM on Ubuntu 20.04

Deepin WeChat and QQ IM can be installed on Ubuntu 20.04 through a ported repository, making the process similar to installing Ubuntu PPA packages. Here’s a short guide on how to do it.

## Step-by-Step Installation Guide

### Step 1: Open Terminal

First, open your terminal from the system application launcher.

### Step 2: Setup Deepin Wine Repository

Run the following command to set up the Deepin Wine repository:
```sh
wget -O- https://deepin-wine.i-m.dev/setup.sh | sh
```
This command will:
- Enable 32-bit architecture (if not already enabled).
- Add an apt repository redirect to the Deepin repository.
- Set the priority to install only the specified apps from that repository.
- Add `XDG_DATA_DIRS` settings for app shortcuts.

You will need to enter your user password and hit Enter when prompted.

### Step 3: Install the Desired Applications

Run the following command to install WeChat:
```sh
sudo apt install com.qq.weixin.deepin
```
For QQ IM, use:
```sh
sudo apt install com.qq.im.deepin
```
Other available apps include:
- Dingding: `com.dingtalk.deepin`
- Ali Wangwang: `com.taobao.wangwang.deepin`
- QQ Music: `com.qq.music.deepin`
- QQ Video: `com.qq.video.deepin`
- iQIYI: `com.iqiyi.deepin`

### Step 4: Log Out and Back In

After installation, log out and log back in to ensure the changes take effect. You can then launch the applications from the system application launcher.

**Note:** The first launch may take a few seconds as it configures the Wine environment.

## Clearing Cache or Removing Applications

### Clearing App Cache

The app data is stored in your `Documents` folder. Remove the relevant sub-folders to clear the app caches.

### Removing Deepin Wine Configurations

The Deepin Wine platform files are located in the `.deepinwine` folder (a hidden file folder). Press `Ctrl+H` to show/hide it in your file browser. You can remove this folder to clear the Wine configurations.

### Removing Applications

To remove an application, use the `apt remove` command. For example, to remove WeChat:
```sh
sudo apt remove --autoremove com.qq.weixin.deepin
```

### Removing Repository Configurations

To remove the repository configurations added in step 1, run the following commands:

```sh
sudo rm /etc/apt/preferences.d/deepin-wine.i-m.dev.pref
sudo rm /etc/apt/sources.list.d/deepin-wine.i-m.dev.list
sudo rm /etc/profile.d/deepin-wine.i-m.dev.sh
```

By following these steps, you can easily install and manage Deepin WeChat and QQ IM on Ubuntu 20.04.
