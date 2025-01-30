When you run `git pull`, only the branches that are **already tracked** are updated. If new branches were added to the remote but are not being pulled, it's likely because they are **not yet tracked** locally.

---

## **🔍 Why does this happen?**
- `git pull` **only updates** the currently checked-out branch if it is tracking a remote branch.
- **New branches** created on the remote **do not** automatically appear in your local repository.
- You need to **fetch** the latest branch information and then check out the new branches.

---

## **✅ Solution 1: Fetch All Remote Branches**
Run:

```bash
git fetch --all
```

This updates your local repository with all new branches and changes **without** modifying your working directory.

To list all remote branches:

```bash
git branch -r
```

---

## **✅ Solution 2: Pull New Remote Branches**
If you want to **automatically pull all remote branches**, use:

```bash
git pull --all
```

This pulls changes for **all tracking branches** but does **not** create new local branches.

---

## **✅ Solution 3: Track a New Remote Branch**
If you see a new branch on the remote and want to track it locally, run:

```bash
git checkout -b my-branch origin/my-branch
```

Or use:

```bash
git switch --track origin/my-branch
```

Now `git pull` will update this branch in the future.

---

## **✅ Solution 4: Automatically Set Tracking for All Branches**
To automatically track all new branches, run:

```bash
git fetch --all
git branch --set-upstream-to=origin/<branch-name>
```

Or use:

```bash
git pull --all --prune
```

---

## **✅ Solution 5: Use `git remote update`**
Sometimes, `git fetch` alone doesn’t update references properly. Use:

```bash
git remote update origin --prune
```

This ensures that new branches are discovered and deleted branches are removed.

---

## **🚀 Summary**
If `git pull` is **not pulling new branches**, try these:
1. **Fetch all branches:** `git fetch --all`
2. **List remote branches:** `git branch -r`
3. **Checkout a new branch:** `git switch --track origin/new-branch`
4. **Pull all branches:** `git pull --all`
5. **Ensure remote branches are updated:** `git remote update --prune`

Let me know if you're still facing issues! 🚀
