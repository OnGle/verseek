<?xml version="1.0" encoding="UTF-8"?>
<?xml-stylesheet ekr_test?>
<leo_file>
<leo_header file_format="2" tnodes="0" max_tnode_index="51" clone_windows="0"/>
<globals body_outline_ratio="0.0996784565916">
	<global_window_position top="0" left="470" height="933" width="800"/>
	<global_log_window_position top="0" left="0" height="0" width="0"/>
</globals>
<preferences/>
<find_panel_settings/>
<vnodes>
<v t="zaril.20101001195902" a="E"><vh>Project</vh>
<v t="zaril.20101001201018" a="E"><vh>development log</vh>
<v t="zaril.20101001195902.1" a="E"><vh>design</vh>
<v t="zaril.20101001195902.2" a="E"><vh>brainstorming</vh></v>
<v t="zaril.20101001233547"><vh>terminology</vh></v>
<v t="zaril.20101001195902.5"><vh>cli syntax and logic</vh></v>
<v t="zaril.20101023064447"><vh>limitations</vh></v>
</v>
<v t="zaril.20101001201018.3" a="E"><vh>implementation</vh>
<v t="zaril.20101001204645"><vh>cli stubs</vh></v>
<v t="zaril.20101001204243" a="E"><vh>setup tests</vh></v>
<v t="zaril.20101001204304" a="E"><vh>support latest version in all types</vh>
<v t="zaril.20101001204304.1"><vh>plain</vh></v>
<v t="zaril.20101001204903"><vh>git single</vh></v>
<v t="zaril.20101002071459"><vh>git</vh></v>
</v>
<v t="zaril.20101005103427"><vh>bug: badly formatted changelog</vh></v>
<v t="zaril.20101007060330" a="E"><vh>support full history</vh>
<v t="zaril.20101019052603" a="E"><vh>git-single</vh></v>
<v t="zaril.20101023044815"><vh>git</vh></v>
<v t="zaril.20101023071537" a="E"><vh>sumo</vh>
<v t="zaril.20101024025802" a="M"><vh>implement list</vh></v>
<v t="zaril.20101024025802.1" a="ETV"><vh>implement seek</vh></v>
</v>
</v>
</v>
</v>
<v t="zaril.20101001200109.1" a="E"><vh>bugs/wishlist</vh>
<v t="zaril.20101023071147"><vh>bug: debian/control must exist for all autoversions</vh></v>
</v>
</v>
</vnodes>
<tnodes>
<t tx="zaril.20101001195902">@nocolor
</t>
<t tx="zaril.20101001195902.1"></t>
<t tx="zaril.20101001195902.2">name
    verseek

    alternatives
        sourceversion    
        dsv
            debiansourceversion
    
source types
    regular directory
        list -&gt; only one version
        seek -&gt; dummy operation

    tagged
        list
            all possible auto-versions

        seek
            saves state
            seeks to version with regular git
            creates changelog

    multi-source git repos

    multi-source Sumo repos
 

cli syntax
    sourceversion-list path
    sourceversion-seek path [ version ]</t>
<t tx="zaril.20101001195902.5">=== ENVIRONMENT

RELEASE (what release to specify in changelog)

=== CLI

operations
    list path -&gt; versions
    seek path [ version ]

verseek -l /path
        lists all versions for the Debian source in that path
            raises error if path is not a valid Debian package

verseek path [ version ]
        if version:
            verify legality of version
            saves current state and seeks to version
                if already in a seek, doesn't save current state
        else:
            restores version prior to seek
                raises error if no seek in progress


</t>
<t tx="zaril.20101001200109.1"></t>
<t tx="zaril.20101001201018"></t>
<t tx="zaril.20101001201018.3">test: unchanged pyproject with trivial changes to wrapper docstring

roadmap/milestones
    cli stubs
    setup tests
    support latest version in all types
    add pool support for subset
    support full history
        support tagged sources
        multi-source git repositories
            create changelog manually
        multi-source sumo repositories
            prerequisite: 
                develop seek capability
                develop commit hooks                

</t>
<t tx="zaril.20101001204243">+ plain
+ git single
+ git
+ sumo

REMINDERS: 
    dpkg-parsechangelog
        parses changelog

    dch --create
        creates a new changelog according to template

</t>
<t tx="zaril.20101001204304">multi-git
multi-sumo</t>
<t tx="zaril.20101001204304.1">list logic
    print the latest version in path

    </t>
<t tx="zaril.20101001204645"></t>
<t tx="zaril.20101001204903">detect logic
    single debian project in Git repositorycd p

calculate version logic
    git-describe commit
    if not, create an untagged autoversion    

list logic
    calculate version (same way scripts/version.sh) does it

seek logic
    verify version
    create changelog


Q: how do we decide what the release for the changelog is?
A: 
    hardwired default
    environment variable
        RELEASE
    cli?
        nah, would just complicate matters

SCRATCH
    git-rev-list

Q: whats the format of the time in the changelog?
A: RFC822
    
	strftime("%a, %d %b %Y %H:%M:%S +0000")
</t>
<t tx="zaril.20101001233547">storage types
    git single
        git repository containing one single package

    git
        git repository containing multiple packages

    plain
        regular directory containing multiple packages

    sumo
        sumo arena containing multiple packages
</t>
<t tx="zaril.20101002071459"></t>
<t tx="zaril.20101005103427">test: dpkg-parsechangelog

parsechangelog/debian: error: badly formatted trailer line, at file debian/changelog line 5
</t>
<t tx="zaril.20101007060330">
git</t>
<t tx="zaril.20101019052603">VERSEEK_HEAD

list logic
    autoversino $(git-rev-list --all)

seek
    if not `git-symbolic-ref VERSEEK_HEAD`:
        git-update-ref VERSEEK_HEAD $(git-symbolic-ref HEAD)

    git-checkout &lt;commit&gt;

seek back
    git-checkout -f $(basename $(git-symbolic-ref VERSEEK_HEAD))
    rm .git/VERSEEK_HEAD
        OR git-symbolic-ref VERSEEK_HEAD ''

seek

Q: can we always rely that head will be pointing to a branch?
A: yes, otherwise we can fail</t>
<t tx="zaril.20101023044815">roadmap
    create a test environment
        pyproject prints a different hello each version

    manually figure out how to list/seek to 

Q: how do we create the changelog?
A:
    change it manually? (with dch)

tips
    edit package inside jaunty.1 chroot

GOTCHA: dch -i creates an ubuntu version
    dch -v 1.2
        or edit manually (cut and paste)


create new test version
    increment hello in pylib/cmd_hello.py
    increment debian/changelog
    commit

listing logic
    branch is either what head is pointing to, or what head used to point to before?
        maybe we can rely on verseek -l not being used in the middle of a seek?

    git-rev-list &lt;branch&gt; path/to/changelog
    parse changelog for each rev


seek restore
seek commit</t>
<t tx="zaril.20101023064447">debian/control must exist for all autoversions
    if you seek back to a version that does not have debian/control - you won't be able to seek back
</t>
<t tx="zaril.20101023071147">ideas:
    maybe filter autoversions that don't have debian/control
        cons: that would be very slow

    we would have to try and git-cat-file blob debian/control for each commit
        if it doesn't exist, filter the autoversion

</t>
<t tx="zaril.20101023071537">testbed 
    original: sumo/tmp/t52
        download pyhello into sumo
        create a bunch of changes (with different versions)
    
    clone: turnkey/tmp/verseek/t52
        checkout individual commits</t>
<t tx="zaril.20101024025802">
verseek list logic
    lookup currently checked out branch's thin counterpart

    git-rev-list &lt;thin-branch&gt; internals/overlay/&lt;path&gt;/debian/changelog
        -&gt; list of thin commits

    parse changelog in each commit -&gt; versions</t>
<t tx="zaril.20101024025802.1">verseek seek logic
    sumo-checkout &lt;thin-commit&gt;
    
    restore: sumo-checkout &lt;saved-branch&gt;</t>
</tnodes>
</leo_file>
