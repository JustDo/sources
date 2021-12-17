### Git 通常用法 [Git 文档](http://git-scm.com/book/zh/v2/Git-分支-分支的新建与合并)

[git 可视化游戏](https://learngitbranching.js.org/)
`vim ~/.gitconfig` Git 全局配置

##### 提交

- `git add -i` [交互式暂存](https://git-scm.com/book/zh/v2/Git-%E5%B7%A5%E5%85%B7-%E4%BA%A4%E4%BA%92%E5%BC%8F%E6%9A%82%E5%AD%98)
- cd 到当前要提交的文件路径<即文件夹下>
- `git add filename` 把文件添加到暂存区
- `git add .` 把所有文件提交到暂存区
- `git add -u`把所有文件添加到暂存区，并将删除文件从仓库中删除
- `git add dir/*` 把目录 dir 下的所有文件提交到暂存区
- `git commit -m "信息"` 提交修改文件及修改信息
- `git commit --amend -m "message"` 重置上一次提交信息
- `git push` 将暂存区内容提交到远程库
- `git push origin branchname` 提交到指定分支

- `关于git commit --amend` 如果上次 commit 以后，有忘记提交的文件，可以如下操作，这样两次 add 的内容就保存在一个 commit 中了

      1. git add file
      2. git commit --amend -m ""

---

##### 查看提交历史

- `git log` 查看提交历史
- `git log --reverse` 从第一次提交开始
- `git log --oneline` 查看简洁的提交记录
- `git log --author=张鹏` 查看张鹏的提交历史
- `git log --graph` 查看分支合并图
- `git log -p <file>` 查看指定文件的提交历史
- `git reflog` 查看本地所有的操作, 包括 rebase 之后被清除了的 commit
- `git blame <file>` 以列表方式查看指定文件提交历史
- `git log --stat` 查看提交了哪些文件
- `git log --patch` 查看提交了哪些更改的内容
- `git log --graph --all --decorate --oneline`
- `git log -p` 查看每次提交的内容差异
- `git log --before={2014-01-01} --after={2014-02-01}` 查看从 2 月 1 号 到 1 月 1 号 的提交
- `git log --before={3.weeks.ago}` 查看 3 周前到现在的提交
- `git show 哈希值` 查看某历史版本的提交内容
- `git show HEAD^`查看上一次提交
- `git show HEAD~3`查看往前三次的提交
- `git log dev..ZP`查看 ZP 中比 dev 多了哪些提交
- `git log master ^dev` 查看 master 中有，而 dev 中没有的内容
- `git log dev...master` 不知道誰的提交多，誰的少，只是想知道有哪些不同

---

###### `查看图形界面`

- `gitk` 查看当前分支历史记录
- `gitk branchname` 查看指定分支的历史记录
- `gitk --all` 查看所有分支

##### 标签 tag

- `git tag v2.0` 创建标签
- `git tag v1.0 commitId` 在某个 commitId 的基础上创建 tag
- `git tag -a v1.0 -m "创建tag" commitId` 在某个 commitId 的基础上创建 tag, 并添加注释
- `git tag` 查看标签
- `git tag -l`按字母表顺序查看标签
- `git tag -d v2.0`删除标签
- `git checkout v0.21` 此时会指向打 v0.21 标签时的代码状态
- `git checkout -b new v1.0` 创建分支 new,将 1.0 的代码拉过去
- `git checkout -b pre origin/pre` 拉取远程特定分支 origin/pre 到本地分支 pre 上
- `git checkout --orphan branchname` 基于当前分支创建新分支，且新分支上没有当前分支的 commit log
- `git push origin --delete tag <tagname>`删除远程 tag
- `git tag -d <tagname>` 删除本地 tag

      通常的git push不会将标签对象提交到git服务器，我们需要进行显式的操作
      $ git push origin v0.1.2 # 将v0.1.2标签提交到git服务器

  $ git push origin –-tags # 将本地所有标签一次性提交到 git 服务器

##### 分支

- `git branch`查看所有本地分支
- `git branch -a`查看本地和远程分支
- `git branch -r`查看远程分支
- `git branch -d`删除本地分支
- `git branch -m oldname newname`本地分支重命名
- `git remote rename oldname newname`重命名远程仓库
- `git chectout <branch>`切换到指定分支
- `git checkout -` 切换到上一个分支
- `git merge <branch>` 合并指定分支到当前分支

- `git branch name` 创建新分支
- `git branch -m 原名 新名` 重命名本地分支
- `git push origin name` 将本地分支推到远程库中
- `git branch -d name`删除本地分支
- `git push origin :name` 删除远程分支 推送一个空分支到远程
- `git push origin --delete <branchName>` 删除远程分支
- `git branch -r -d origin/branch-name`删除远程分支
- `git branch --set-upstream [branch] [remote-branch]`建立追踪关系，在现有分支与指定的远程分支之间

##### rebase 对某一段线性 commit 进行编辑，删除，复制，粘贴

- `git rebase -i A^..B` 交互式合并多次连续提交
- `git rebase -i HEAD~3` 重写最后三次的提交
- `git rebase -i [startPoint] [endPoint]` 不包含 startPoint, 如需包含, A^ B

      1. 自动打开编辑器, 列出三个 commit , 将第一条 pick 修改为 edit/pick, 其它改为 s, wq退出
      2. 如果选择 `git rebase --continue` , 进入编辑器， 三次commit msg 上加上西郊合并需要写的msg
      3. 如果选择 ` git commit --amend -m "msg"` 直接修改合并信息，其它三个commit 去除

      注意: 如果是想把某一次commit 删除, 直接在交互当中删除或改为drop 并保存 wq 即可

- `git rebase [startpoint] [endpoint] --onto [targetBranch]` 将其它分支区间内的 commit 复制到指定分支

      如果 HEAD 不在target分支
      1. `git checkout targetBranch` 切换到指定分支
      2. `git reset --hard [endpoint]`

##### 合并

- `git pull --rebase origin dev` 拉取所有上游提交命令到小红的本地仓库，并尝试和她的本地修改合并
- `git rebase --abort` 发现冲突，无法解决时，回到 pull 之前的状态
- `git diff` 显示冲突部分
- `git merge tool` 引导解决冲突

- `git rebase branchname`衍合某一个分支

          如果衍合发生冲突，会自动暂停,解决冲突后 git add,  git rebase --continue即可

##### 暂存

- `git stash` 保存工作现场， 就可直接切换到其它分支
- `git stash push -m "暂时保存" filepath` 暂存指定文件
- `git stash save "message"` 备注保存进度的信息
- `git stash list` 查看 stash 队列
- `git stash drop stash@{0}` 删除编号为 0 的进度
- `git stash pop stash@{0}` 恢复编号为 0 的进度的工
  作区和暂存区, list 中删除, 有冲突时在 list 中不会消失
- `git stash apply` 恢复工作, list 中还有
- `git stash clear`清除所有进度<工作现场>
- `git stash -u` 将所有修改缓存, 包括 add 文件

##### Bisect 二分查找

1. `git bisect start [近期commit] [久远commit]` 在两个 commit 区间内启动查错
2. 刷新页面，如果正常, 未出现所要找的 bug, 则执行 `git bisect good`, 二分指针 向 > 1/2 的 commit 运动
   如果出现所要找的异常 bug 情况， 则执行 `git bisect bad` , 二分指针 向 < 1/2 的 commit 运动

   `7dfc49a42 is the first bad commit`
   这里就是出现问题的的第一次 commit

3. 检查代码,找出错误原因，然后 `git bisect reset`, 退出查错, 回到最近的 commit

   刷新页面后，未出现 bug ， 执行 'good'

##### 提交部分文件

方法一

- `git add demo.html` 提交到暂存区
- `git stash -u -k` 忽略其他修改，关键一步
- `git commit -m` '修改演示文件'
- `git pull`
- `git push`
- `git stash pop` // 恢复之前忽略的文件（非常重要的一步）

方法二

- `git add demo.html` 提交到暂存区
- `git commit -m` '修改演示文件'
- `git stash` 暂存
- `git pull`
- `git push`
- `git stash pop` // 恢复之前忽略的文件（非常重要的一步）

##### 区别

- `git diff ZP..origin/ZP` 查看本地分支和远程分支的区别
- `git diff`查看暂存前后的变化
- `git diff --cached`查看已暂存起来的变化
- `git diff 哈希值 filename` 查看某次提交某个文件的修改

#### 撤消

- `git checkout -- filename`取消对文件的修改, 清除已跟踪的变更
- `git clean -f -d` 清除所有未跟踪的变更，即: 清除新添加文件
- `git reset --hard` 取消上一步更新
- `git reset --hard 哈希值`回退到指定版本, 此时状态: 此 hash 之后的 commit 消失, 所做修改全部无效
- `git reset --hard HEAD^`放弃本地所有修改，回退到上一个版本
- `git reset --hard HEAD~3`放弃本地所有修改，回退到指定版本
- `git reset --soft 哈希值`回退到指定版本, 此时状态: 此前修改的文件已 add , 但未 commit
- `git reset hash`撤消 commit，此时状态: 取消 add, 直接回到红色状态, 已修改的内容还在
- `git reset filepath`只能在 add 之后操作，可以回退到 add 之前 ， 如果已经 commit, 此命令无效

#### 查责

- `git blame filename` 列出文件中每一行的变更时间与作者
- `将new 分支的修改应用到 new2分支上`

      1. new 分支上完成 add . 及 commit, 查看log,复制 commit哈希值
      2. 切换到new2分支
      3. `git cherry-pick 哈希值A` 将new分支上的 A 应用到 new2分支上

         `git cherry-pick A^..B`  将new分支上的 A到B的连续commit 应用到 new2分支上 <包含A,B>

         `git cherry-pick A B C`  将new分支上的A,B,C 应用到new2分支上<随意的三个commit,不要求连续>

#### 子模块

- 主项目添加第三方仓库的子模块

       1. git clone https://main.git , cd main
       2. git submodule add https://sub.git
       3. git status , git add ,git commit, git push

- clone 含有子模块的项目

      1. git clone 主项目<main> 默认包含子模块目录, 但是空目录
      2. cd 主目录,  git submodule init 初使化本地配置文件
      3. git submodule update 抓取子模块的数据，并检出子模块最后的提交
      4. 此命令等同于前三步  git clone https://main.git  --recursive
      5. git checkout master 切换到master分支

- 更新主项目中的子模块

  <font size=2 color='red'>子模块作为第三方库的时候，可能会被多个其它项目引用, 此时子模块在 git 上是单独的仓库, 修改此仓库中的代码需要[ 其它引用它的项目 ]同步更新</font>

      1. 在子模块仓库中修改代码, git add ,git commit ,git push
      2. 其它引用它的项目
            cd 子模块目录 , git branch 查看当前所在分支
            git checkout master
            git pull / git pull --rebase
      3. 返回 main , git add , commit ,push

  <font size=2 color='red'>在主项目中修改子模块代码, 其它引用子模块的项目更新</font>

         先提交 sub, 再提交 main
      1. 主项目main1/sub , 修改代码, cd 子模块,git  add ,commit ,  push
      2. 返回到主项目 main1 目录, git status , add ,commit , push

          先pull sub, 再pull main
      3. 主项目main2, cd 子模块, git checkout master, git pull (--rebase)
      4. 返回主项目main2, git pull (--rebase)

  <font size=2 color='red'>在主项目中未修改子模块代码, 不必提交子模块, 其它引用子模块的项目也不必更新子模块</font>

- 删除子模块: 第一种方式

      1. rm -rf 子模块目录 删除子模块目录及源码
      2. vi .gitmodules 删除项目目录下.gitmodules文件中子模块相关条目
      3. vi .git/config 删除配置项中子模块相关条目
      4. rm .git/module/* 删除模块下的子模块目录，每个子模块对应一个目录，注意只删除对应的子模块目录即可

      注意: 执行完成后，再执行添加子模块命令即可，如果仍然报错，执行如下：

            git rm --cached 子模块名称

            完成删除后，提交到仓库即可

- 删除子模块: 第二种方式

      1. cd 到main中，git submodule deinit 子模块目录名称
      2. git rm 子模块目录名称
      3. git add , commit ,push

- 子模块其它命令

      1. 在 main 更新所有子模块,git submodule update --remote
      2. 在 main,  git diff --submodule 查看子模块更新后的变化

- 流程

      1. 先更新/提交子模块代码，提交, push
      2. 再更新主项目

#### git 配置

- `git config --global alias.co checkout`
- `git config --global alias.ci commit`
- `git config --global alias.sta status` 命令别名
- `git config apply.whitespace nowarn` 忽略空格的改变
- `git config --global credential.helper store` 永久存储密码, 避免每次都重新输入账号密码

## 流程

- 方案 1 所有人在一个分支时

        1. add . commit
        2. pull --rebase
        3. 解决冲突
        4. push

- 方案 2 每人一个分支时, 不推荐

        1. 在各自分支 add . commit
        2. 切换到dev, pull --rebase
        3. 解决冲突
        4. merge 本人分支
        5. push
        6. 保证自己分支每天的代码是dev最新的

## 项目迁移

- cd 到项目目录下, cd .git/ 更改 conf 中的 ip 或 url
- push 到新的仓库

`如何让新仓库不包含原仓库的commit`

- 1.从最全代码分支，切换出新的分支, 新分支不包含任何原来的 commit

  `git checkout --orphan branchname`

- 2.缓存所有文件（除了.gitignore 中声明排除的）

  `git add -A`

- 3.提交跟踪过的文件（Commit the changes）

  `git commit -am "commit message"`

- 4.删除 master 分支（Delete the branch）

  `git branch -D master`

- 5.重命名当前分支为 master（Rename the current branch to master）

  `git branch -m master`

- 6.提交到远程 master 分支 （Finally, force update your repository）

  `git push -f origin master`

#### 注意

- 本机和远程的相同分支使用 rebase。如果是不同分支的合并则必须用 merge，否则会导致历史记录不可读，因为再也找不到合并之前各个分支到底是在哪里[地址](http://www.toobug.net/article/git_and_gitflow.html)
- 多提交 commit ,功能没写完也可提交,最后要 push 的时候再 --amend 一下就行<只能修改最后一次 commit>
- 合并多个 commit, `git reset HEAD~3`,`git add .`,`git commit -m`

- expr (void)NSLog(@"shopname=%@,shopAddress=%@",shop.title,shop.address) 条件断点打印多个变量值

##### 参考

- [Git 流程](http://www.kuqin.com/shuoit/20151105/348774.html)
- [具体操作](http://www.kuqin.com/shuoit/20151209/349401.html)
- [视频](http://www.nowcoder.com/courses/2/1/8)
- [深入理解学习 Git 工作流](http://segmentfault.com/a/1190000002918123)
- [不再追踪管理](http://www.cnblogs.com/bandy/p/3558912.html)

---

#### 常见问题

1. 放弃跟踪项目中的文件

    gitignore 只能忽略那些原来没有被 track 的文件，如果某些文件已经被纳入了版本管理中，则修改.gitignore 是无效的。
    正确的做法是在每个 clone 下来的仓库中手动设置不要检查特定文件的更改情况。

         git update-index --assume-unchanged PATH    在PATH处输入要忽略的文件


         git rm -r --cached .
         <添加 忽略内容到.ignore>
         git add .
         git commit -m 'update .gitignore'


        touch .gitignore //创建
        open .gitignore //打开

2. 第二种方法

        cd 进入到根目录 .git/info 中, vi exclude文件, 直接把要忽略的内容添加进去
