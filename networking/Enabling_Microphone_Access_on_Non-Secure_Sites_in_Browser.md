## 🎙️ Guide: Enable Microphone Access on a Non-Secure (HTTP) Site for Local Development

When building or testing web apps locally (like React + FastAPI, Flask, etc.), Chrome and Firefox **block microphone/camera APIs** unless the site is served over **HTTPS**.
This guide helps you **unblock** those features safely for **development only**.

---

## ⚠️ The Problem

If your app runs on:

```
http://192.168.1.8:8005
```

and you try:

```js
navigator.mediaDevices.getUserMedia({ audio: true })
```

you’ll get:

> ❌ “getUserMedia() only works in secure contexts (HTTPS).”

Browsers do this to protect users — microphone and camera access normally require HTTPS.

---

## ✅ Solution 1: For Google Chrome

### 🧠 Command

```bash
google-chrome --unsafely-treat-insecure-origin-as-secure=http://192.168.1.8:8005 --user-data-dir=/tmp
```

### 🔍 Explanation

| Part                                                                 | Meaning                                                                           |
| -------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `google-chrome`                                                      | Launches Chrome manually.                                                         |
| `--unsafely-treat-insecure-origin-as-secure=http://192.168.1.8:8005` | Temporarily treats the HTTP site as HTTPS, unlocking mic/camera APIs.             |
| `--user-data-dir=/tmp`                                               | Opens a clean temporary Chrome profile so it doesn’t conflict with your main one. |

### ⚙️ Steps

1. Close all running Chrome windows.
2. Open your terminal and run the command above.
3. Chrome will start with a new temporary profile.
4. Visit your site → `http://192.168.1.8:8005`
5. Grant microphone permission when prompted.

✅ Microphone and camera will now work **as if the site were secure**.

### ⚠️ Notes

* Use **only for local testing**. Never for production.
* Every time you close Chrome, `/tmp` profile resets (safe and temporary).

---

## ✅ Solution 2: For Mozilla Firefox

Firefox handles this slightly differently. You can **override HTTPS-only restrictions** using configuration flags.

### ⚙️ Steps

1. Open Firefox.

2. In the address bar, type:

   ```
   about:config
   ```

3. Accept the warning: *“Proceed with caution.”*

4. Search for:

   ```
   media.devices.insecure.enabled
   ```

5. Set it to **true**.

   * This allows `navigator.mediaDevices.getUserMedia()` on **HTTP** origins (for development).

6. Optionally, also check:

   ```
   dom.security.https_only_mode
   ```

   Set to **false** if it’s enforcing HTTPS-only mode.

7. Restart Firefox, then visit your site:

   ```
   http://192.168.1.8:8005
   ```

8. Allow microphone access when prompted.

✅ Microphone will now work on HTTP during development.

---

## 🔍 Browser Support Check

Make sure your browser supports `getUserMedia()` API:

| Supported          | Not Supported                        |
| ------------------ | ------------------------------------ |
| ✅ Chrome (latest)  | ❌ Facebook/Instagram in-app browsers |
| ✅ Edge (latest)    | ❌ Older Android WebView apps         |
| ✅ Firefox (latest) | ❌ Outdated mobile browsers           |
| ✅ Safari (recent)  |                                      |

🧭 **Fix:**
Always open your app in a **full standalone browser**:

* **Desktop:** Chrome, Firefox, Edge, Safari
* **Mobile:** “Open in browser” instead of in-app viewer

---

## 💡 Memorization Trick

🧠 “**Unsafe treat = makes HTTP feel safe.**”

> Chrome: use `--unsafely-treat-insecure-origin-as-secure`
> Firefox: toggle `media.devices.insecure.enabled`

---

## 🧰 Example Use Case

You’re testing a local React + FastAPI app:

```
Frontend: http://192.168.1.8:5173
Backend:  http://192.168.1.8:8005
```

and you use microphone input for a voice feature.

**Chrome solution:**

```bash
google-chrome --unsafely-treat-insecure-origin-as-secure=http://192.168.1.8:8005 --user-data-dir=/tmp
```

**Firefox solution:**
Set `media.devices.insecure.enabled` to **true** under `about:config`.

Now both browsers will allow microphone usage safely for testing.

---


