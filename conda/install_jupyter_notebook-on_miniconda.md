To use **Jupyter Notebook** with Miniconda on Ubuntu, follow these steps:

### 1. **Install Jupyter Notebook**

If you haven't already installed Jupyter Notebook, you can install it using Conda. First, make sure that Conda is properly set up and activated. Then, run the following command to install Jupyter Notebook:

```bash
conda install jupyter
```

This will install Jupyter Notebook along with its dependencies.

### 2. **Verify Jupyter Installation**

Once the installation is complete, you can verify that Jupyter Notebook is installed by running:

```bash
jupyter --version
```

This should output the version of Jupyter Notebook installed.

### 3. **Launch Jupyter Notebook**

To start a Jupyter Notebook session, simply run:

```bash
jupyter notebook
```

This will launch a local Jupyter Notebook server. By default, the notebook server will open in your default web browser, and the URL will be something like:

```
http://localhost:8888
```

If the browser doesn't open automatically, you can manually open the URL in your browser.

### 4. **Creating a New Notebook**

Once the Jupyter Notebook interface is loaded in your browser:

1. Click the **New** button on the right-hand side.
2. Select **Python 3** (or another kernel if you're using one) to create a new notebook.
3. You can now start writing and running code in the notebook cells.

### 5. **Using a Specific Conda Environment in Jupyter Notebook (Optional)**

If you want to use a specific Conda environment in your Jupyter Notebook, you can add it as a kernel. Here’s how:

1. First, activate the Conda environment that you want to use:

   ```bash
   conda activate <your-environment-name>
   ```

2. Install `ipykernel` in that environment:

   ```bash
   conda install ipykernel
   ```

3. Add the environment to Jupyter as a kernel:

   ```bash
   python -m ipykernel install --user --name <your-environment-name> --display-name "Python (<your-environment-name>)"
   ```

4. Now, when you create a new notebook, you can select this environment as a kernel by clicking on the **Kernel** dropdown and choosing the appropriate environment.

### 6. **Stop the Jupyter Server**

To stop the Jupyter Notebook server, simply go back to the terminal where the server is running and press `CTRL+C`.

This will stop the server.

### 7. **(Optional) Run Jupyter Notebook in the Background**

If you want to keep the Jupyter Notebook running in the background, you can use `nohup` or run it in a `tmux` session:

```bash
nohup jupyter notebook &
```

This will allow the notebook server to run even if you close the terminal session.

---
