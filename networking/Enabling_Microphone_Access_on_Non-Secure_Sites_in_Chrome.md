## 🎙️ Guide: Enabling Microphone Access on Non-Secure (HTTP) Sites in Chrome

### 🧩 Problem

When your web app runs on **HTTP** (like `http://192.168.1.8:8005`), Chrome automatically **blocks** features that require a **secure context (HTTPS)** — such as:

* Microphone and Camera access
* Geolocation
* Clipboard or Notifications
* Service Workers

You might see an error like:

> “getUserMedia() only works in secure contexts (HTTPS).”

---

## ✅ Solution: Run Chrome with Development Flags

### 🧠 Command

```bash
google-chrome --unsafely-treat-insecure-origin-as-secure=http://192.168.1.8:8005 --user-data-dir=/tmp
```

### 🔍 Explanation

| Part                                                                 | Purpose                                                                                                        |
| -------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------- |
| `google-chrome`                                                      | Launches the Chrome browser manually from terminal.                                                            |
| `--unsafely-treat-insecure-origin-as-secure=http://192.168.1.8:8005` | Tells Chrome to treat your **HTTP** site as **HTTPS**, unlocking mic/camera APIs for local testing.            |
| `--user-data-dir=/tmp`                                               | Opens Chrome with a **temporary user profile** (since your main one can’t use this flag for security reasons). |

---

### ⚙️ Steps

1. **Close all Chrome windows** (to avoid profile conflicts).
2. **Open a terminal** and run the command:

   ```bash
   google-chrome --unsafely-treat-insecure-origin-as-secure=http://192.168.1.8:8005 --user-data-dir=/tmp
   ```
3. Chrome will start with a **fresh temporary profile**.
4. Visit your site, e.g.:

   ```
   http://192.168.1.8:8005
   ```
5. Try using the microphone — Chrome will now **allow permission prompts** as if it were HTTPS.

---

### 🚫 Important Notes

* Only use this method for **local development** or **LAN testing**.
* Do **not** use it for production — it bypasses real HTTPS security checks.
* Each time you restart, Chrome will create a **fresh temporary profile** under `/tmp`.

---

### 🔍 Browser Support Check

Before troubleshooting, make sure your browser supports microphone APIs (`navigator.mediaDevices.getUserMedia()`):

✅ **Supported browsers:**

* Chrome (latest)
* Edge (latest)
* Firefox (latest)
* Safari (recent versions)

❌ **Not supported in:**

* In-app browsers (Facebook, Instagram)
* Old Android WebViews
* Outdated browsers

🧭 **Fix:**
Open your app in a **full browser**:

* **Desktop:** Chrome, Firefox, Edge, Safari
* **Mobile:** Tap menu → “Open in browser”

---

### 💡 Memorization Trick

> **Unsafe treat = makes HTTP feel safe.**

Remember:

> “I’m treating insecure origins as secure — but only for development.”

---
