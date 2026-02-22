### What is **CERT_COMMON_NAME**?

**CERT_COMMON_NAME** refers to the **Common Name (CN)** field inside an SSL/TLS certificate.

It represents:

> The primary domain name the certificate is issued for.

---

## 🔐 Where It Exists

In an X.509 SSL certificate, you’ll find something like:

```
Subject: CN=example.com
```

That `CN=example.com` is the **Common Name**.

---

## 🚨 Why It Matters

When a browser connects to:

```
https://example.com
```

It checks:

1. Does the certificate’s Common Name match `example.com`?
2. Or is `example.com` listed in the SAN (Subject Alternative Name)?

If not → browser throws:

```
NET::ERR_CERT_COMMON_NAME_INVALID
```

---

## 🧠 Example Scenarios

### ✅ Correct Case

Certificate issued for:

```
CN = example.com
```

User visits:

```
https://example.com
```

✔ Works fine.

---

### ❌ Mismatch Case

Certificate issued for:

```
CN = example.net
```

User visits:

```
https://example.com
```

🚫 Browser shows:

> Your connection is not private
> NET::ERR_CERT_COMMON_NAME_INVALID

Because the certificate name does not match the requested hostname.

---

## 🔎 Modern Behavior (Important)

Today, browsers primarily validate against:

### SAN (Subject Alternative Name)

Example certificate:

```
CN = example.com
SAN = example.com, www.example.com, api.example.com
```

If the domain is inside SAN, it works — even if CN differs.

👉 SAN is what really matters now.
CN is mostly legacy but still shown in errors.

---

## 🛠 How to Check It

### Using OpenSSL:

```bash
openssl s_client -connect example.com:443 -servername example.com
```

Look for:

```
Subject: CN=
X509v3 Subject Alternative Name:
```

---

## 💡 Common DevOps Causes

You’ll see this error when:

* Wrong certificate installed on server
* Reverse proxy serving default cert
* Cloudflare in Flexible mode
* Old IP still resolving
* CDN misconfiguration
* Multiple virtual hosts but default cert used

---

## 🎯 Quick Memory Trick

Think:

> **Common Name = “Who is this certificate for?”**

If the answer doesn’t match the domain in the browser → error.

---

