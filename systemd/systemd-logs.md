This is a very common confusion—systemctl and journalctl both deal with logs, but they serve different roles.


---

🧠 Core Difference

Tool	Purpose

systemctl	Manage services (start/stop/status)
journalctl	View logs (systemd journal)


👉 Think:

> systemctl = control
journalctl = observe




---

🔍 1. systemctl logs (limited view)

Example:

systemctl status nginx

What you get:

Service status (running, failed, etc.)

Last few log lines only


Example output:

● nginx.service - A high performance web server
   Active: active (running)
   ...
   Mar 18 10:00:01 error: failed to bind port

👉 It’s just a quick snapshot, not full logs.


---

📜 2. journalctl logs (full power)

Example:

journalctl -u nginx

What you get:

Complete logs for the service

Historical logs

Filtering, searching, time-based queries



---

⚙️ Common journalctl Usage

🔹 Live logs (like tail -f)

journalctl -u nginx -f


---

🔹 Last boot logs

journalctl -b


---

🔹 Previous boot

journalctl -b -1


---

🔹 Time-based filtering

journalctl --since "1 hour ago"


---

🔹 Errors only

journalctl -p err


---

🔹 Specific service + today

journalctl -u nginx --since today


---

⚖️ Side-by-Side

Feature	systemctl status	journalctl

Shows logs	✅ (few lines)	✅ (full logs)
Historical logs	❌	✅
Live streaming	❌	✅ (-f)
Filtering	❌	✅
Primary use	Service status	Log analysis



---

🔧 Real DevOps Workflow

Debugging a failed service:

# Step 1: Quick check
systemctl status myapp

# Step 2: Deep dive
journalctl -u myapp -xe


---

🧠 What -xe means

journalctl -xe

-x → extra explanation

-e → jump to end


👉 Very useful for troubleshooting


---

🔥 Practical Example

Problem:

Your FastAPI app fails to start

systemctl status myapp

Shows:

Active: failed

Then:

journalctl -u myapp -n 50 --no-pager

You see:

Error: Address already in use

👉 Now you know port conflict issue


---

⚠️ Important Notes

Logs are stored in:

/var/log/journal/

If persistent logging disabled → logs lost after reboot


Enable persistent logs:

sudo mkdir -p /var/log/journal
sudo systemctl restart systemd-journald


---

🧠 Memorization Trick

> “systemctl shows state, journalctl shows story”



systemctl → current status

journalctl → full history



---

💡 Pro Tips (Production)

Limit logs to avoid disk issues:

journalctl --vacuum-time=7d

Check disk usage:

journalctl --disk-usage


---

If you want, I can show:

How to ship journalctl logs to ELK / Loki / Prometheus stack

Or how to centralize logs across servers using Fluent Bit / rsyslog