### **Installing Go 1.24.1 on Linux (Manual Installation)**  

To install **Go 1.24.1** on Linux manually, follow these steps:

---

### **Step 1: Download Go 1.24.1**
Run the following command to download the Go binary package:  
```bash
wget https://go.dev/dl/go1.24.1.linux-amd64.tar.gz
```
*(Make sure to check [Go’s official website](https://go.dev/dl/) for the latest version.)*

---

### **Step 2: Remove Any Previous Go Installation**  
If you have an older version installed, remove it first:  
```bash
sudo rm -rf /usr/local/go
```

---

### **Step 3: Extract and Install Go**  
Extract the downloaded archive to `/usr/local`:  
```bash
sudo tar -C /usr/local -xzf go1.24.1.linux-amd64.tar.gz
```

---

### **Step 4: Configure Environment Variables**  
Add Go’s binary path to your shell profile (`~/.bashrc`, `~/.profile`, or `~/.zshrc`):  
```bash
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
echo 'export GOPATH=$HOME/go' >> ~/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.bashrc
source ~/.bashrc
```
For **Zsh users**, replace `~/.bashrc` with `~/.zshrc`.

---

### **Step 5: Verify Installation**  
Check if Go is installed correctly:  
```bash
go version
```
Expected output:  
```
go version go1.24.1 linux/amd64
```

---

### **Step 6: Test Go Installation**  
1. Create a test directory:  
   ```bash
   mkdir -p ~/go/src/hello
   cd ~/go/src/hello
   ```
2. Create a Go program:  
   ```bash
   nano hello.go
   ```
   Paste the following code:  
   ```go
   package main

   import "fmt"

   func main() {
       fmt.Println("Hello, Go!")
   }
   ```
3. Run the program:  
   ```bash
   go run hello.go
   ```
   Expected output:  
   ```
   Hello, Go!
   ```

---

### **Conclusion**  
✅ **Go 1.24.1** is now installed and configured.  
✅ Environment variables are set (`PATH`, `GOPATH`).  
✅ You have tested Go with a basic program.

Would you like help setting up a Go project? 🚀
