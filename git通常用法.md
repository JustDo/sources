### Git通常用法 [Git文档](http://git-scm.com/book/zh/v2/Git-分支-分支的新建与合并)

##### 提交
 - cd 到当前要提交的文件路径<即文件夹下>
 - `git add filename` 把文件添加到暂存区
 - `git add .` 把所有文件提交到暂存区
 - `git add -u`把所有文件添加到暂存区，并将删除文件从仓库中删除
 - `git commit -m "信息"` 提交修改文件及修改信息
 - `git commit --amend -m "message"` 重置上一次提交信息
 - `git push` 将暂存区内容提交到远程库
 - `git push origin branchname` 提交到指定分支
 
 ---
##### 查看提交历史

- `git log` 查看提交历史
- `git log --oneline` 查看简洁的提交记录
- `git log --author=张鹏` 查看张鹏的提交历史
- `git log --graph` 查看分支合并图
- `git log -p <file>` 查看指定文件的提交历史
- `git blame <file>` 以列表方式查看指定文件提交历史
- `git log --stat` 查看提交了哪些文件
- `git log --patch` 查看提交了哪些更改的内容
- `git log --graph --all --decorate --oneline`
- `git log -p` 查看每次提交的内容差异
- `git show 4ebd4bbc3ed321d01484a4ed206f18ce2ebde5ca` 查看某历史版本的提交内容
- `git show HEAD^`查看上一次提交
- `git show HEAD~3`查看往前三次的提交
- `git log dev..ZP`查看ZP中哪些没被提交到dev上

---
###### `查看图形界面`
- `gitk` 查看当前分支历史记录 
- `gitk branchname` 查看指定分支的历史记录
- `gitk --all` 查看所有分支

##### 标签 tag

- `git tag v2.0` 创建标签
- `git tag` 查看标签
- `git tag -l`按字母表顺序查看标签
- `git tag -d v2.0`删除标签
- `git  checkout v0.21` 此时会指向打v0.21标签时的代码状态
- `git push origin --delete tag <tagname>`删除远程tag
- `git tag -d <tagname>` 删除本地tag

        
      通常的git push不会将标签对象提交到git服务器，我们需要进行显式的操作
      $ git push origin v0.1.2 # 将v0.1.2标签提交到git服务器
	  $ git push origin –-tags # 将本地所有标签一次性提交到git服务器
	  

##### 分支
- `git branch`查看所有本地分支
- `git branch -a`查看本地和远程分支
- `git branch -r`查看远程分支
- `git branch -d`删除本地分支
- `git chectout <branch>`切换到指定分支
- `git merge <branch>` 合并指定分支到当前分支

- `git branch name` 创建新分支
- `git branch -m 原名 新名` 重命名本地分支
- `git push origin name` 将本地分支推到远程库中
- `git branch -d name`删除本地分支
- `git push origin :name` 删除远程分支 推送一个空分支到远程
- `git push origin --delete <branchName>` 删除远程分支
- `git branch -r -d origin/branch-name`删除远程分支
-  `git branch --set-upstream [branch] [remote-branch]`建立追踪关系，在现有分支与指定的远程分支之间

##### 合并
- `git pull --rebase origin dev` 拉取所有上游提交命令到小红的本地仓库，并尝试和她的本地修改合并 
- `git rebase --abort` 发现冲突，无法解决时，回到pull 之前的状态
- `git diff` 显示冲突部分 
- `git merge tool` 引导解决冲突

- `git rebase branchname`衍合某一个分支
          
          如果衍合发生冲突，会自动暂停,解决冲突后 git add,  git rebase --continue即可


##### 中途中断
- `git stash` 保存工作现场， 就可直接切换到其它分支
- `git stash save "message"` 备注保存进度的信息
- `git stash list` 查看stash队列 
- `git stash drop stash@{0}` 删除编号为0 的进度
- `git stash pop stash@{0}` 恢复编号为0的进度的工
作区和暂存区, list 中无
-  `git stash apply` 恢复工作, list中还有
- `git stash clear`清除所有进度<工作现场>

##### 区别
- `git diff ZP..origin/ZP` 查看本地分支和远程分支的区别
- `git diff`查看暂存前后的变化
- `git diff --cached`查看已暂存起来的变化


#### 撤消
- `git checkout -- filename`取消对文件的修改
- `git reset --hard` 取消上一步更新
- `git reset --hard 哈希值`回退到指定版本- 
- `git reset --hard HEAD^`放弃本地所有修改，回退到上一个版本
- `git reset --hard HEAD~3`放弃本地所有修改，回退到指定版本
- `git reset HEAD`撤消加入暂存，即取消add


#### 修改命令
- `git config --global alias.co checkout`
- `git config --global alias.ci commit`
- `git config --global alias.sta status` 命令别名

### 流程
  
  方案 1.
---
  1. 切换到dev `git pull origin dev`更新dev中的代码
  2. 切换到 自己branch 进行开发，提交修改 , 合并到dev 解决冲突
  3. 整个版本开发完成后,切换到master,
  4. `git merge dev` 将dev 合并到了master
  
  方案 2.
---
   0. 分别测试下 push 和不push的情况
   1. chectout 当前分支, git fetch origin dev
   2. git rebase origin/dev
   3. 如果有冲突 解决之， git add . ,git rebase --continue
   3. git push  
   4.   git merge --no-ff feature-branch 试试
  
  
  方案 3.
---
   1. 自己分支add , commit ,push
   2. dev, pull --rebase
   3. merge 自己分支
   3. git push  

  
   
  
#### 注意
- 本机和远程的相同分支使用rebase。如果是不同分支的合并则必须用merge，否则会导致历史记录不可读，因为再也找不到合并之前各个分支到底是在哪里[地址](http://www.toobug.net/article/git_and_gitflow.html)
- 多提交commit ,功能没写完也可提交,最后要push的时候再 --amend一下就行<只能修改最后一次commit>
- 合并多个commit,  `git reset HEAD~3`,`git add .`,`git commit -m`


- expr (void)NSLog(@"shopname=%@,shopAddress=%@",shop.title,shop.address) 条件断点打印多个变量值


##### 参考 

- [Git流程](http://www.kuqin.com/shuoit/20151105/348774.html)
- [具体操作](http://www.kuqin.com/shuoit/20151209/349401.html)
- [视频](http://www.nowcoder.com/courses/2/1/8)
- [深入理解学习Git工作流](http://segmentfault.com/a/1190000002918123)
- [不再追踪管理](http://www.cnblogs.com/bandy/p/3558912.html)

---

####常见问题

 1. 项目中有些配置文件在服务器上做了修改 ,本地又添加了些修改，再次push ,pull ,checkout 的时候可能会出错
             
        error: Your local changes to the following files would be overwritten by merge:protected/config/main.php
        
        Please, commit your changes or stash them before you can merge.
        
    `解决方案`
   
        如果希望保留生产服务器上所做的改动,仅仅并入新配置项, 处理方法如下:

        git stash
	    git pull
		git stash pop
		然后可以使用git diff -w +文件名 来确认代码自动合并的情况.

		反过来,如果希望用代码库中的文件完全覆盖本地工作版本. 方法如下:

		git reset --hard
		git pull
    
 2. 放弃跟踪项目中的文件
 
 	  	 gitignore只能忽略那些原来没有被track的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore是无效的。
        正确的做法是在每个clone下来的仓库中手动设置不要检查特定文件的更改情况。
        
   		 git update-index --assume-unchanged PATH    在PATH处输入要忽略的文件
 	

3. Xcode项目中的某些文件解读 [项目文件](http://blog.csdn.net/lixing333/article/details/47700687)

4. 分叉
            
        Your branch and 'origin/ZP' have diverged,
		and have 2 and 4 different commits each, respectively.
		  (use "git pull" to merge the remote branch into yours)
		nothing to commit, working directory clean
	`解决方案`
		1. git cherry  git pull --rebase origin <自己分支或Dev>
		2. git add .  git rebase --continue