





<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
  <link rel="dns-prefetch" href="https://assets-cdn.github.com">
  <link rel="dns-prefetch" href="https://avatars0.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars1.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars2.githubusercontent.com">
  <link rel="dns-prefetch" href="https://avatars3.githubusercontent.com">
  <link rel="dns-prefetch" href="https://github-cloud.s3.amazonaws.com">
  <link rel="dns-prefetch" href="https://user-images.githubusercontent.com/">

<meta content="origin-when-cross-origin" name="referrer" />

  <link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/frameworks-bedfc518345498ab3204d330c1727cde7e733526a09cd7df6867f6a231565091.css" integrity="sha256-vt/FGDRUmKsyBNMwwXJ83n5zNSagnNffaGf2ojFWUJE=" media="all" rel="stylesheet" />
  <link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/github-7fe2b92304082e7579ea9aaf717b05ebef9288ada19f3ff3afeca11b72e5f4aa.css" integrity="sha256-f+K5IwQILnV56pqvcXsF6++SiK2hnz/zr+yhG3Ll9Ko=" media="all" rel="stylesheet" />
  
  
  
  

  <meta name="viewport" content="width=device-width">
  
  <title>helix-powershell-poc/hMSBuild.bat at issue-22/modulariation · PentiaLabs/helix-powershell-poc</title>
  <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
  <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
  <meta property="fb:app_id" content="1401488693436528">

    
    <meta content="https://avatars2.githubusercontent.com/u/4137220?v=4&amp;s=400" property="og:image" /><meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="PentiaLabs/helix-powershell-poc" property="og:title" /><meta content="https://github.com/PentiaLabs/helix-powershell-poc" property="og:url" /><meta content="helix-powershell-poc - Powershell module PoC for helix" property="og:description" />

  <link rel="assets" href="https://assets-cdn.github.com/">
  <link rel="web-socket" href="wss://live.github.com/_sockets/VjI6MTkwMDQ2NDI5OjNmYTI4MmI3YzE4NzM4MjczZDYzMjQyNzA1MmRkMzMwNThiZTc4OGZkMmVhNjMyZjdiNWM0ZDc0MzFkODc0YzU=--32dcd71514e1b80cdc6870c1a0efa09d99493f7b">
  <meta name="pjax-timeout" content="1000">
  <link rel="sudo-modal" href="/sessions/sudo_modal">
  <meta name="request-id" content="DEEC:655C:51C92AE:873D070:59BB87E6" data-pjax-transient>
  

  <meta name="selected-link" value="repo_source" data-pjax-transient>

  <meta name="google-site-verification" content="KT5gs8h0wvaagLKAVWq8bbeNwnZZK1r1XQysX3xurLU">
<meta name="google-site-verification" content="ZzhVyEFwb7w3e0-uOTltm8Jsck2F5StVihD0exw2fsA">
    <meta name="google-analytics" content="UA-3769691-2">

<meta content="collector.githubapp.com" name="octolytics-host" /><meta content="github" name="octolytics-app-id" /><meta content="https://collector.githubapp.com/github-external/browser_event" name="octolytics-event-url" /><meta content="DEEC:655C:51C92AE:873D070:59BB87E6" name="octolytics-dimension-request_id" /><meta content="iad" name="octolytics-dimension-region_edge" /><meta content="iad" name="octolytics-dimension-region_render" /><meta content="1416006" name="octolytics-actor-id" /><meta content="uli-weltersbach" name="octolytics-actor-login" /><meta content="4815d40d605ccce624c2a3ef4d51f230ae7f5d346323cae9ed6ee1a194422de9" name="octolytics-actor-hash" />
<meta content="/&lt;user-name&gt;/&lt;repo-name&gt;/blob/show" data-pjax-transient="true" name="analytics-location" />




  <meta class="js-ga-set" name="dimension1" content="Logged In">


  

      <meta name="hostname" content="github.com">
  <meta name="user-login" content="uli-weltersbach">

      <meta name="expected-hostname" content="github.com">
    <meta name="js-proxy-site-detection-payload" content="NmU0NGM2YTgwZDMyNDUwZWIzNTU3Njc3NjlhNDBlODhmOGI3OGI1MGIwZDlhZGM3MmNmOTg1ZTI2NDM3MmM5Ynx7InJlbW90ZV9hZGRyZXNzIjoiNzcuMjMzLjI1MC40IiwicmVxdWVzdF9pZCI6IkRFRUM6NjU1Qzo1MUM5MkFFOjg3M0QwNzA6NTlCQjg3RTYiLCJ0aW1lc3RhbXAiOjE1MDU0NjIyNTQsImhvc3QiOiJnaXRodWIuY29tIn0=">

    <meta name="enabled-features" content="UNIVERSE_BANNER">

  <meta name="html-safe-nonce" content="7398ffcf43cda0e1744c0b6b1500462bf6814b91">

  <meta http-equiv="x-pjax-version" content="827b3e6280111eb78ad994604c97dbdc">
  

      <link href="https://github.com/PentiaLabs/helix-powershell-poc/commits/issue-22/modulariation.atom?token=ABWbRmZYPmrK9po-uhBhiVwgJvxGtVufks63x3b-wA%3D%3D" rel="alternate" title="Recent Commits to helix-powershell-poc:issue-22/modulariation" type="application/atom+xml">

  <meta name="description" content="helix-powershell-poc - Powershell module PoC for helix">
  <meta name="go-import" content="github.com/PentiaLabs/helix-powershell-poc git https://github.com/PentiaLabs/helix-powershell-poc.git">

  <meta content="4137220" name="octolytics-dimension-user_id" /><meta content="PentiaLabs" name="octolytics-dimension-user_login" /><meta content="97567655" name="octolytics-dimension-repository_id" /><meta content="PentiaLabs/helix-powershell-poc" name="octolytics-dimension-repository_nwo" /><meta content="false" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="97567655" name="octolytics-dimension-repository_network_root_id" /><meta content="PentiaLabs/helix-powershell-poc" name="octolytics-dimension-repository_network_root_nwo" /><meta content="false" name="octolytics-dimension-repository_explore_github_marketplace_ci_cta_shown" />


    <link rel="canonical" href="https://github.com/PentiaLabs/helix-powershell-poc/blob/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat" data-pjax-transient>


  <meta name="browser-stats-url" content="https://api.github.com/_private/browser/stats">

  <meta name="browser-errors-url" content="https://api.github.com/_private/browser/errors">

  <link rel="mask-icon" href="https://assets-cdn.github.com/pinned-octocat.svg" color="#000000">
  <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico">

<meta name="theme-color" content="#1e2327">


  <meta name="u2f-support" content="true">

  </head>

  <body class="logged-in env-production page-blob">
    

  <div class="position-relative js-header-wrapper ">
    <a href="#start-of-content" tabindex="1" class="bg-black text-white p-3 show-on-focus js-skip-to-content">Skip to content</a>
    <div id="js-pjax-loader-bar" class="pjax-loader-bar"><div class="progress"></div></div>

    
    
    



        
<header class="Header  f5" role="banner">
  <div class="d-flex px-3 flex-justify-between container-lg">
    <div class="d-flex flex-justify-between">
      <a class="header-logo-invertocat" href="https://github.com/orgs/PentiaLabs/dashboard" data-hotkey="g d" aria-label="Homepage" data-ga-click="Header, go to dashboard, icon:logo">
  <svg aria-hidden="true" class="octicon octicon-mark-github" height="32" version="1.1" viewBox="0 0 16 16" width="32"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
</a>


    </div>

    <div class="HeaderMenu d-flex flex-justify-between flex-auto">
      <div class="d-flex">
            <div class="">
              <div class="header-search scoped-search site-scoped-search js-site-search" role="search">
  <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/PentiaLabs/helix-powershell-poc/search" class="js-site-search-form" data-scoped-search-url="/PentiaLabs/helix-powershell-poc/search" data-unscoped-search-url="/search" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
    <label class="form-control header-search-wrapper js-chromeless-input-container">
        <a href="/PentiaLabs/helix-powershell-poc/blob/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat" class="header-search-scope no-underline">This repository</a>
      <input type="text"
        class="form-control header-search-input js-site-search-focus js-site-search-field is-clearable"
        data-hotkey="s"
        name="q"
        value=""
        placeholder="Search"
        aria-label="Search this repository"
        data-unscoped-placeholder="Search GitHub"
        data-scoped-placeholder="Search"
        autocapitalize="off">
        <input type="hidden" class="js-site-search-type-field" name="type" >
    </label>
</form></div>

            </div>

          <ul class="d-flex pl-2 flex-items-center text-bold list-style-none" role="navigation">
            <li>
              <a href="/pulls" aria-label="Pull requests you created" class="js-selected-navigation-item HeaderNavlink px-2" data-ga-click="Header, click, Nav menu - item:pulls context:user" data-hotkey="g p" data-selected-links="/pulls /pulls/assigned /pulls/mentioned /pulls">
                Pull requests
</a>            </li>
            <li>
              <a href="/issues" aria-label="Issues you created" class="js-selected-navigation-item HeaderNavlink px-2" data-ga-click="Header, click, Nav menu - item:issues context:user" data-hotkey="g i" data-selected-links="/issues /issues/assigned /issues/mentioned /issues">
                Issues
</a>            </li>
                <li>
                  <a href="/marketplace" class="js-selected-navigation-item HeaderNavlink px-2" data-ga-click="Header, click, Nav menu - item:marketplace context:user" data-selected-links=" /marketplace">
                    Marketplace
</a>                </li>
            <li>
              <a href="/explore" class="js-selected-navigation-item HeaderNavlink px-2" data-ga-click="Header, click, Nav menu - item:explore" data-selected-links="/explore /trending /trending/developers /integrations /integrations/feature/code /integrations/feature/collaborate /integrations/feature/ship showcases showcases_search showcases_landing /explore">
                Explore
</a>            </li>
          </ul>
      </div>

      <div class="d-flex">
        
<ul class="user-nav d-flex flex-items-center list-style-none" id="user-links">
  <li class="dropdown js-menu-container js-header-notifications">
    <span class="d-inline-block  px-2">
      
      <a href="/notifications" aria-label="You have no unread notifications" class="notification-indicator tooltipped tooltipped-s  js-socket-channel js-notification-indicator" data-channel="notification-changed:1416006" data-ga-click="Header, go to notifications, icon:read" data-hotkey="g n">
          <span class="mail-status "></span>
          <svg aria-hidden="true" class="octicon octicon-bell" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M14 12v1H0v-1l.73-.58c.77-.77.81-2.55 1.19-4.42C2.69 3.23 6 2 6 2c0-.55.45-1 1-1s1 .45 1 1c0 0 3.39 1.23 4.16 5 .38 1.88.42 3.66 1.19 4.42l.66.58H14zm-7 4c1.11 0 2-.89 2-2H5c0 1.11.89 2 2 2z"/></svg>
</a>
    </span>
  </li>

  <li class="dropdown js-menu-container">
    <details class="dropdown-details js-dropdown-details d-flex px-2 flex-items-center">
      <summary class="HeaderNavlink"
         aria-label="Create new…"
         data-ga-click="Header, create new, icon:add">
        <svg aria-hidden="true" class="octicon octicon-plus float-left mr-1 mt-1" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M12 9H7v5H5V9H0V7h5V2h2v5h5z"/></svg>
        <span class="dropdown-caret mt-1"></span>
      </summary>

      <ul class="dropdown-menu dropdown-menu-sw">
        
<a class="dropdown-item" href="/new" data-ga-click="Header, create new repository">
  New repository
</a>

  <a class="dropdown-item" href="/new/import" data-ga-click="Header, import a repository">
    Import repository
  </a>

<a class="dropdown-item" href="https://gist.github.com/" data-ga-click="Header, create new gist">
  New gist
</a>

  <a class="dropdown-item" href="/organizations/new" data-ga-click="Header, create new organization">
    New organization
  </a>



  <div class="dropdown-divider"></div>
  <div class="dropdown-header">
    <span title="PentiaLabs/helix-powershell-poc">This repository</span>
  </div>
    <a class="dropdown-item" href="/PentiaLabs/helix-powershell-poc/issues/new" data-ga-click="Header, create new issue">
      New issue
    </a>

      </ul>
    </details>
  </li>

  <li class="dropdown js-menu-container">

    <details class="dropdown-details js-dropdown-details d-flex pl-2 flex-items-center">
      <summary class="HeaderNavlink name mt-1"
        aria-label="View profile and more"
        data-ga-click="Header, show menu, icon:avatar">
        <img alt="@uli-weltersbach" class="avatar float-left mr-1" src="https://avatars1.githubusercontent.com/u/1416006?v=4&amp;s=40" height="20" width="20">
        <span class="dropdown-caret"></span>
      </summary>

      <ul class="dropdown-menu dropdown-menu-sw">
        <li class="dropdown-header header-nav-current-user css-truncate">
          Signed in as <strong class="css-truncate-target">uli-weltersbach</strong>
        </li>

        <li class="dropdown-divider"></li>

        <li><a class="dropdown-item" href="/uli-weltersbach" data-ga-click="Header, go to profile, text:your profile">
          Your profile
        </a></li>
        <li><a class="dropdown-item" href="/uli-weltersbach?tab=stars" data-ga-click="Header, go to starred repos, text:your stars">
          Your stars
        </a></li>
          <li><a class="dropdown-item" href="https://gist.github.com/" data-ga-click="Header, your gists, text:your gists">Your Gists</a></li>

        <li class="dropdown-divider"></li>

        <li><a class="dropdown-item" href="https://help.github.com" data-ga-click="Header, go to help, text:help">
          Help
        </a></li>

        <li><a class="dropdown-item" href="/settings/profile" data-ga-click="Header, go to settings, icon:settings">
          Settings
        </a></li>

        <li><!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/logout" class="logout-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="Jwc+B6a4HYIqZeXEiLt5RmJa2BuGqHiPD76TXIQvYIiTl/v0xvm2uZaOC5GrJtywWj12JkH19sh42RCNDBlWTA==" /></div>
          <button type="submit" class="dropdown-item dropdown-signout" data-ga-click="Header, sign out, icon:logout">
            Sign out
          </button>
        </form></li>
      </ul>
    </details>
  </li>
</ul>


        <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/logout" class="sr-only right-0" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="Hj5GFF+OkVA2WU+qfUpdr/2TVEUiVNDopfw53a+2n6mqroPnP886a4qyof9e1/hZxfT6eOUJXq/Sm7oMJ4CpbQ==" /></div>
          <button type="submit" class="dropdown-item dropdown-signout" data-ga-click="Header, sign out, icon:logout">
            Sign out
          </button>
</form>      </div>
    </div>
  </div>
</header>


      

  </div>

  <div id="start-of-content" class="show-on-focus"></div>

    <div id="js-flash-container">
</div>



  <div role="main">
        <div itemscope itemtype="http://schema.org/SoftwareSourceCode">
    <div id="js-repo-pjax-container" data-pjax-container>
      



  



    <div class="pagehead repohead instapaper_ignore readability-menu experiment-repo-nav">
      <div class="container repohead-details-container">

        <ul class="pagehead-actions">
  <li>
        <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/notifications/subscribe" class="js-social-container" data-autosubmit="true" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="xY27lDQGTIDJBvgOoTSnYUKLFxucgcD3fopa12XxuSLhHjcl07NXrsOpYdUjkxiSXCQOlxvnBtN+i7aUeb3sfA==" /></div>      <input class="form-control" id="repository_id" name="repository_id" type="hidden" value="97567655" />

        <div class="select-menu js-menu-container js-select-menu">
          <a href="/PentiaLabs/helix-powershell-poc/subscription"
            class="btn btn-sm btn-with-count select-menu-button js-menu-target"
            role="button"
            aria-haspopup="true"
            aria-expanded="false"
            aria-label="Toggle repository notifications menu"
            data-ga-click="Repository, click Watch settings, action:blob#show">
            <span class="js-select-button">
                <svg aria-hidden="true" class="octicon octicon-eye" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>
                Watch
            </span>
          </a>
            <a class="social-count js-social-count"
              href="/PentiaLabs/helix-powershell-poc/watchers"
              aria-label="36 users are watching this repository">
              36
            </a>

        <div class="select-menu-modal-holder">
          <div class="select-menu-modal subscription-menu-modal js-menu-content">
            <div class="select-menu-header js-navigation-enable" tabindex="-1">
              <svg aria-label="Close" class="octicon octicon-x js-menu-close" height="16" role="img" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
              <span class="select-menu-title">Notifications</span>
            </div>

              <div class="select-menu-list js-navigation-container" role="menu">

                <div class="select-menu-item js-navigation-item selected" role="menuitem" tabindex="0">
                  <svg aria-hidden="true" class="octicon octicon-check select-menu-item-icon" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5z"/></svg>
                  <div class="select-menu-item-text">
                    <input checked="checked" id="do_included" name="do" type="radio" value="included" />
                    <span class="select-menu-item-heading">Not watching</span>
                    <span class="description">Be notified when participating or @mentioned.</span>
                    <span class="js-select-button-text hidden-select-button-text">
                      <svg aria-hidden="true" class="octicon octicon-eye" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>
                      Watch
                    </span>
                  </div>
                </div>

                <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
                  <svg aria-hidden="true" class="octicon octicon-check select-menu-item-icon" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5z"/></svg>
                  <div class="select-menu-item-text">
                    <input id="do_subscribed" name="do" type="radio" value="subscribed" />
                    <span class="select-menu-item-heading">Watching</span>
                    <span class="description">Be notified of all conversations.</span>
                    <span class="js-select-button-text hidden-select-button-text">
                      <svg aria-hidden="true" class="octicon octicon-eye" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6C13 14 16 8 16 8s-3-6-7.94-6zM8 12c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4zm2-4c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"/></svg>
                        Unwatch
                    </span>
                  </div>
                </div>

                <div class="select-menu-item js-navigation-item " role="menuitem" tabindex="0">
                  <svg aria-hidden="true" class="octicon octicon-check select-menu-item-icon" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5z"/></svg>
                  <div class="select-menu-item-text">
                    <input id="do_ignore" name="do" type="radio" value="ignore" />
                    <span class="select-menu-item-heading">Ignoring</span>
                    <span class="description">Never be notified.</span>
                    <span class="js-select-button-text hidden-select-button-text">
                      <svg aria-hidden="true" class="octicon octicon-mute" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8 2.81v10.38c0 .67-.81 1-1.28.53L3 10H1c-.55 0-1-.45-1-1V7c0-.55.45-1 1-1h2l3.72-3.72C7.19 1.81 8 2.14 8 2.81zm7.53 3.22l-1.06-1.06-1.97 1.97-1.97-1.97-1.06 1.06L11.44 8 9.47 9.97l1.06 1.06 1.97-1.97 1.97 1.97 1.06-1.06L13.56 8l1.97-1.97z"/></svg>
                        Stop ignoring
                    </span>
                  </div>
                </div>

              </div>

            </div>
          </div>
        </div>
</form>
  </li>

  <li>
    
  <div class="js-toggler-container js-social-container starring-container ">
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/PentiaLabs/helix-powershell-poc/unstar" class="starred" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="knqv1Ivy4q4hlggPZszKgA1utIqWaL+to+ELb4ERJmxsEb0SjKKp61/hrABkLFXIVcCGs7flO70e0k9BoXt3Jw==" /></div>
      <button
        type="submit"
        class="btn btn-sm btn-with-count js-toggler-target"
        aria-label="Unstar this repository" title="Unstar PentiaLabs/helix-powershell-poc"
        data-ga-click="Repository, click unstar button, action:blob#show; text:Unstar">
        <svg aria-hidden="true" class="octicon octicon-star" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74z"/></svg>
        Unstar
      </button>
        <a class="social-count js-social-count" href="/PentiaLabs/helix-powershell-poc/stargazers"
           aria-label="0 users starred this repository">
          0
        </a>
</form>
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/PentiaLabs/helix-powershell-poc/star" class="unstarred" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="dpy7zLBfJUQVjBYYgeLDIrt3+vUa7fLHSGOMikeMaGih0XBP7DbP6s0GUKUmgyqCcWwYPOhoznuBYdKe9pTQWA==" /></div>
      <button
        type="submit"
        class="btn btn-sm btn-with-count js-toggler-target"
        aria-label="Star this repository" title="Star PentiaLabs/helix-powershell-poc"
        data-ga-click="Repository, click star button, action:blob#show; text:Star">
        <svg aria-hidden="true" class="octicon octicon-star" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M14 6l-4.9-.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14 7 11.67 11.33 14l-.93-4.74z"/></svg>
        Star
      </button>
        <a class="social-count js-social-count" href="/PentiaLabs/helix-powershell-poc/stargazers"
           aria-label="0 users starred this repository">
          0
        </a>
</form>  </div>

  </li>

  <li>
          <a href="#fork-destination-box" class="btn btn-sm btn-with-count"
              title="Fork your own copy of PentiaLabs/helix-powershell-poc to your account"
              aria-label="Fork your own copy of PentiaLabs/helix-powershell-poc to your account"
              rel="facebox"
              data-ga-click="Repository, show fork modal, action:blob#show; text:Fork">
              <svg aria-hidden="true" class="octicon octicon-repo-forked" height="16" version="1.1" viewBox="0 0 10 16" width="10"><path fill-rule="evenodd" d="M8 1a1.993 1.993 0 0 0-1 3.72V6L5 8 3 6V4.72A1.993 1.993 0 0 0 2 1a1.993 1.993 0 0 0-1 3.72V6.5l3 3v1.78A1.993 1.993 0 0 0 5 15a1.993 1.993 0 0 0 1-3.72V9.5l3-3V4.72A1.993 1.993 0 0 0 8 1zM2 4.2C1.34 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3 10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm3-10c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z"/></svg>
            Fork
          </a>

          <div id="fork-destination-box" style="display: none;">
            <h2 class="facebox-header" data-facebox-id="facebox-header">Where should we fork this repository?</h2>
            <include-fragment src=""
                class="js-fork-select-fragment fork-select-fragment"
                data-url="/PentiaLabs/helix-powershell-poc/fork?fragment=1">
              <img alt="Loading" height="64" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-128.gif" width="64" />
            </include-fragment>
          </div>

    <a href="/PentiaLabs/helix-powershell-poc/network" class="social-count"
       aria-label="0 users forked this repository">
      0
    </a>
  </li>
</ul>

        <h1 class="private ">
  <svg aria-hidden="true" class="octicon octicon-lock" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M4 13H3v-1h1v1zm8-6v7c0 .55-.45 1-1 1H1c-.55 0-1-.45-1-1V7c0-.55.45-1 1-1h1V4c0-2.2 1.8-4 4-4s4 1.8 4 4v2h1c.55 0 1 .45 1 1zM3.8 6h4.41V4c0-1.22-.98-2.2-2.2-2.2-1.22 0-2.2.98-2.2 2.2v2H3.8zM11 7H2v7h9V7zM4 8H3v1h1V8zm0 2H3v1h1v-1z"/></svg>
  <span class="author" itemprop="author"><a href="/PentiaLabs" class="url fn" rel="author">PentiaLabs</a></span><!--
--><span class="path-divider">/</span><!--
--><strong itemprop="name"><a href="/PentiaLabs/helix-powershell-poc" data-pjax="#js-repo-pjax-container">helix-powershell-poc</a></strong>
    <span class="Label Label--outline v-align-middle">Private</span>

</h1>

      </div>
      <div class="container">
        
<nav class="reponav js-repo-nav js-sidenav-container-pjax"
     itemscope
     itemtype="http://schema.org/BreadcrumbList"
     role="navigation"
     data-pjax="#js-repo-pjax-container">

  <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
    <a href="/PentiaLabs/helix-powershell-poc/tree/issue-22/modulariation" class="js-selected-navigation-item selected reponav-item" data-hotkey="g c" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /PentiaLabs/helix-powershell-poc/tree/issue-22/modulariation" itemprop="url">
      <svg aria-hidden="true" class="octicon octicon-code" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M9.5 3L8 4.5 11.5 8 8 11.5 9.5 13 14 8 9.5 3zm-5 0L0 8l4.5 5L6 11.5 2.5 8 6 4.5 4.5 3z"/></svg>
      <span itemprop="name">Code</span>
      <meta itemprop="position" content="1">
</a>  </span>

    <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
      <a href="/PentiaLabs/helix-powershell-poc/issues" class="js-selected-navigation-item reponav-item" data-hotkey="g i" data-selected-links="repo_issues repo_labels repo_milestones /PentiaLabs/helix-powershell-poc/issues" itemprop="url">
        <svg aria-hidden="true" class="octicon octicon-issue-opened" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M7 2.3c3.14 0 5.7 2.56 5.7 5.7s-2.56 5.7-5.7 5.7A5.71 5.71 0 0 1 1.3 8c0-3.14 2.56-5.7 5.7-5.7zM7 1C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7-3.14-7-7-7zm1 3H6v5h2V4zm0 6H6v2h2v-2z"/></svg>
        <span itemprop="name">Issues</span>
        <span class="Counter">7</span>
        <meta itemprop="position" content="2">
</a>    </span>

  <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
    <a href="/PentiaLabs/helix-powershell-poc/pulls" class="js-selected-navigation-item reponav-item" data-hotkey="g p" data-selected-links="repo_pulls /PentiaLabs/helix-powershell-poc/pulls" itemprop="url">
      <svg aria-hidden="true" class="octicon octicon-git-pull-request" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M11 11.28V5c-.03-.78-.34-1.47-.94-2.06C9.46 2.35 8.78 2.03 8 2H7V0L4 3l3 3V4h1c.27.02.48.11.69.31.21.2.3.42.31.69v6.28A1.993 1.993 0 0 0 10 15a1.993 1.993 0 0 0 1-3.72zm-1 2.92c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zM4 3c0-1.11-.89-2-2-2a1.993 1.993 0 0 0-1 3.72v6.56A1.993 1.993 0 0 0 2 15a1.993 1.993 0 0 0 1-3.72V4.72c.59-.34 1-.98 1-1.72zm-.8 10c0 .66-.55 1.2-1.2 1.2-.65 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2zM2 4.2C1.34 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z"/></svg>
      <span itemprop="name">Pull requests</span>
      <span class="Counter">0</span>
      <meta itemprop="position" content="3">
</a>  </span>

    <a href="/PentiaLabs/helix-powershell-poc/projects" class="js-selected-navigation-item reponav-item" data-selected-links="repo_projects new_repo_project repo_project /PentiaLabs/helix-powershell-poc/projects">
      <svg aria-hidden="true" class="octicon octicon-project" height="16" version="1.1" viewBox="0 0 15 16" width="15"><path fill-rule="evenodd" d="M10 12h3V2h-3v10zm-4-2h3V2H6v8zm-4 4h3V2H2v12zm-1 1h13V1H1v14zM14 0H1a1 1 0 0 0-1 1v14a1 1 0 0 0 1 1h13a1 1 0 0 0 1-1V1a1 1 0 0 0-1-1z"/></svg>
      Projects
      <span class="Counter" >0</span>
</a>
    <a href="/PentiaLabs/helix-powershell-poc/wiki" class="js-selected-navigation-item reponav-item" data-hotkey="g w" data-selected-links="repo_wiki /PentiaLabs/helix-powershell-poc/wiki">
      <svg aria-hidden="true" class="octicon octicon-book" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M3 5h4v1H3V5zm0 3h4V7H3v1zm0 2h4V9H3v1zm11-5h-4v1h4V5zm0 2h-4v1h4V7zm0 2h-4v1h4V9zm2-6v9c0 .55-.45 1-1 1H9.5l-1 1-1-1H2c-.55 0-1-.45-1-1V3c0-.55.45-1 1-1h5.5l1 1 1-1H15c.55 0 1 .45 1 1zm-8 .5L7.5 3H2v9h6V3.5zm7-.5H9.5l-.5.5V12h6V3z"/></svg>
      Wiki
</a>
      <a href="/PentiaLabs/helix-powershell-poc/settings" class="js-selected-navigation-item reponav-item" data-selected-links="repo_settings repo_branch_settings hooks integration_installations /PentiaLabs/helix-powershell-poc/settings">
        <svg aria-hidden="true" class="octicon octicon-gear" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M14 8.77v-1.6l-1.94-.64-.45-1.09.88-1.84-1.13-1.13-1.81.91-1.09-.45-.69-1.92h-1.6l-.63 1.94-1.11.45-1.84-.88-1.13 1.13.91 1.81-.45 1.09L0 7.23v1.59l1.94.64.45 1.09-.88 1.84 1.13 1.13 1.81-.91 1.09.45.69 1.92h1.59l.63-1.94 1.11-.45 1.84.88 1.13-1.13-.92-1.81.47-1.09L14 8.75v.02zM7 11c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3z"/></svg>
        Settings
</a>
    <div class="reponav-dropdown js-menu-container">
      <button type="button" class="btn-link reponav-item reponav-dropdown js-menu-target " data-no-toggle aria-expanded="false" aria-haspopup="true">
        Insights
        <svg aria-hidden="true" class="octicon octicon-triangle-down v-align-middle text-gray" height="11" version="1.1" viewBox="0 0 12 16" width="8"><path fill-rule="evenodd" d="M0 5l6 6 6-6z"/></svg>
      </button>
      <div class="dropdown-menu-content js-menu-content">
        <div class="dropdown-menu dropdown-menu-sw">
          <a class="dropdown-item" href="/PentiaLabs/helix-powershell-poc/pulse" data-skip-pjax>
            <svg aria-hidden="true" class="octicon octicon-pulse" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M11.5 8L8.8 5.4 6.6 8.5 5.5 1.6 2.38 8H0v2h3.6l.9-1.8.9 5.4L9 8.5l1.6 1.5H14V8z"/></svg>
            Pulse
          </a>
          <a class="dropdown-item" href="/PentiaLabs/helix-powershell-poc/graphs" data-skip-pjax>
            <svg aria-hidden="true" class="octicon octicon-graph" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M16 14v1H0V0h1v14h15zM5 13H3V8h2v5zm4 0H7V3h2v10zm4 0h-2V6h2v7z"/></svg>
            Graphs
          </a>
        </div>
      </div>
    </div>
</nav>

      </div>
    </div>

<div class="container new-discussion-timeline experiment-repo-nav">
  <div class="repository-content">

    
  <a href="/PentiaLabs/helix-powershell-poc/blob/ef19eb559b74deb66fe7775dad866dd2b134b96c/Get-MSBuild/lib/hMSBuild.bat" class="d-none js-permalink-shortcut" data-hotkey="y">Permalink</a>

  <!-- blob contrib key: blob_contributors:v21:3c2bd9f3dacd2d9442336627f0f7d86e -->

  <div class="file-navigation js-zeroclipboard-container">
    
<div class="select-menu branch-select-menu js-menu-container js-select-menu float-left">
  <button class=" btn btn-sm select-menu-button js-menu-target css-truncate" data-hotkey="w"
    title="issue-22/modulariation"
    type="button" aria-label="Switch branches or tags" aria-expanded="false" aria-haspopup="true">
      <i>Branch:</i>
      <span class="js-select-button css-truncate-target">issue-22/modul…</span>
  </button>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax>

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <svg aria-label="Close" class="octicon octicon-x js-menu-close" height="16" role="img" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
        <span class="select-menu-title">Switch branches/tags</span>
      </div>

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Find or create a branch…" id="context-commitish-filter-field" class="form-control js-filterable-field js-navigation-enable" placeholder="Find or create a branch…">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" data-filter-placeholder="Find or create a branch…" class="js-select-menu-tab" role="tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" data-filter-placeholder="Find a tag…" class="js-select-menu-tab" role="tab">Tags</a>
            </li>
          </ul>
        </div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches" role="menu">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <a class="select-menu-item js-navigation-item js-navigation-open selected"
               href="/PentiaLabs/helix-powershell-poc/blob/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat"
               data-name="issue-22/modulariation"
               data-skip-pjax="true"
               rel="nofollow">
              <svg aria-hidden="true" class="octicon octicon-check select-menu-item-icon" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5z"/></svg>
              <span class="select-menu-item-text css-truncate-target js-select-menu-filter-text">
                issue-22/modulariation
              </span>
            </a>
            <a class="select-menu-item js-navigation-item js-navigation-open "
               href="/PentiaLabs/helix-powershell-poc/blob/master/Get-MSBuild/lib/hMSBuild.bat"
               data-name="master"
               data-skip-pjax="true"
               rel="nofollow">
              <svg aria-hidden="true" class="octicon octicon-check select-menu-item-icon" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M12 5l-8 8-4-4 1.5-1.5L4 10l6.5-6.5z"/></svg>
              <span class="select-menu-item-text css-truncate-target js-select-menu-filter-text">
                master
              </span>
            </a>
        </div>

          <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/PentiaLabs/helix-powershell-poc/branches" class="js-create-branch select-menu-item select-menu-new-item-form js-navigation-item js-new-item-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="6KppiysA0J4oEy9YL2aNh6mX/hkGJUfHaCpG/0jKQ6VrPjBkyGucA7wcc6EZW/NDjGHzqUvKdj1BryvjKF4umQ==" /></div>
          <svg aria-hidden="true" class="octicon octicon-git-branch select-menu-item-icon" height="16" version="1.1" viewBox="0 0 10 16" width="10"><path fill-rule="evenodd" d="M10 5c0-1.11-.89-2-2-2a1.993 1.993 0 0 0-1 3.72v.3c-.02.52-.23.98-.63 1.38-.4.4-.86.61-1.38.63-.83.02-1.48.16-2 .45V4.72a1.993 1.993 0 0 0-1-3.72C.88 1 0 1.89 0 3a2 2 0 0 0 1 1.72v6.56c-.59.35-1 .99-1 1.72 0 1.11.89 2 2 2 1.11 0 2-.89 2-2 0-.53-.2-1-.53-1.36.09-.06.48-.41.59-.47.25-.11.56-.17.94-.17 1.05-.05 1.95-.45 2.75-1.25S8.95 7.77 9 6.73h-.02C9.59 6.37 10 5.73 10 5zM2 1.8c.66 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2C1.35 4.2.8 3.65.8 3c0-.65.55-1.2 1.2-1.2zm0 12.41c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2zm6-8c-.66 0-1.2-.55-1.2-1.2 0-.65.55-1.2 1.2-1.2.65 0 1.2.55 1.2 1.2 0 .65-.55 1.2-1.2 1.2z"/></svg>
            <div class="select-menu-item-text">
              <span class="select-menu-item-heading">Create branch: <span class="js-new-item-name"></span></span>
              <span class="description">from ‘issue-22/modulariation’</span>
            </div>
            <input type="hidden" name="name" id="name" class="js-new-item-value">
            <input type="hidden" name="branch" id="branch" value="issue-22/modulariation">
            <input type="hidden" name="path" id="path" value="Get-MSBuild/lib/hMSBuild.bat">
</form>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div>

    </div>
  </div>
</div>

    <div class="BtnGroup float-right">
      <a href="/PentiaLabs/helix-powershell-poc/find/issue-22/modulariation"
            class="js-pjax-capture-input btn btn-sm BtnGroup-item"
            data-pjax
            data-hotkey="t">
        Find file
      </a>
      <button aria-label="Copy file path to clipboard" class="js-zeroclipboard btn btn-sm BtnGroup-item tooltipped tooltipped-s" data-copied-hint="Copied!" type="button">Copy path</button>
    </div>
    <div class="breadcrumb js-zeroclipboard-target">
      <span class="repo-root js-repo-root"><span class="js-path-segment"><a href="/PentiaLabs/helix-powershell-poc/tree/issue-22/modulariation"><span>helix-powershell-poc</span></a></span></span><span class="separator">/</span><span class="js-path-segment"><a href="/PentiaLabs/helix-powershell-poc/tree/issue-22/modulariation/Get-MSBuild"><span>Get-MSBuild</span></a></span><span class="separator">/</span><span class="js-path-segment"><a href="/PentiaLabs/helix-powershell-poc/tree/issue-22/modulariation/Get-MSBuild/lib"><span>lib</span></a></span><span class="separator">/</span><strong class="final-path">hMSBuild.bat</strong>
    </div>
  </div>


  <include-fragment class="commit-tease" src="/PentiaLabs/helix-powershell-poc/contributors/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat">
    <div>
      Fetching contributors&hellip;
    </div>

    <div class="commit-tease-contributors">
      <img alt="" class="loader-loading float-left" height="16" src="https://assets-cdn.github.com/images/spinners/octocat-spinner-32-EAF2F5.gif" width="16" />
      <span class="loader-error">Cannot retrieve contributors at this time</span>
    </div>
</include-fragment>

  <div class="file">
    <div class="file-header">
  <div class="file-actions">

    <div class="BtnGroup">
      <a href="/PentiaLabs/helix-powershell-poc/raw/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat" class="btn btn-sm BtnGroup-item" id="raw-url">Raw</a>
        <a href="/PentiaLabs/helix-powershell-poc/blame/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat" class="btn btn-sm js-update-url-with-hash BtnGroup-item" data-hotkey="b">Blame</a>
      <a href="/PentiaLabs/helix-powershell-poc/commits/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat" class="btn btn-sm BtnGroup-item" rel="nofollow">History</a>
    </div>

        <a class="btn-octicon tooltipped tooltipped-nw"
           href="github-windows://openRepo/https://github.com/PentiaLabs/helix-powershell-poc?branch=issue-22%2Fmodulariation&amp;filepath=Get-MSBuild%2Flib%2FhMSBuild.bat"
           aria-label="Open this file in GitHub Desktop"
           data-ga-click="Repository, open with desktop, type:windows">
            <svg aria-hidden="true" class="octicon octicon-device-desktop" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M15 2H1c-.55 0-1 .45-1 1v9c0 .55.45 1 1 1h5.34c-.25.61-.86 1.39-2.34 2h8c-1.48-.61-2.09-1.39-2.34-2H15c.55 0 1-.45 1-1V3c0-.55-.45-1-1-1zm0 9H1V3h14v8z"/></svg>
        </a>

        <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/PentiaLabs/helix-powershell-poc/edit/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat" class="inline-form js-update-url-with-hash" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="HcJfUbJG9t4Kt60YNNN0O8Nvju7kRjoxnOyJSN9iR7UGfmT+bXSauyS5K3H5jL2lRTI5vyExCKcGsgrM7eXLiw==" /></div>
          <button class="btn-octicon tooltipped tooltipped-nw" type="submit"
            aria-label="Edit this file" data-hotkey="e" data-disable-with>
            <svg aria-hidden="true" class="octicon octicon-pencil" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path fill-rule="evenodd" d="M0 12v3h3l8-8-3-3-8 8zm3 2H1v-2h1v1h1v1zm10.3-9.3L12 6 9 3l1.3-1.3a.996.996 0 0 1 1.41 0l1.59 1.59c.39.39.39 1.02 0 1.41z"/></svg>
          </button>
</form>        <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="/PentiaLabs/helix-powershell-poc/delete/issue-22/modulariation/Get-MSBuild/lib/hMSBuild.bat" class="inline-form" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="gt+SAQY4o5+hQjb/J3BKB5cBHttU/oLRS7ff/Jr4XUU4Z37BmFDxC9Q6XlFm8zswNDxW09Y5/4lqXXs5oaApog==" /></div>
          <button class="btn-octicon btn-octicon-danger tooltipped tooltipped-nw" type="submit"
            aria-label="Delete this file" data-disable-with>
            <svg aria-hidden="true" class="octicon octicon-trashcan" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M11 2H9c0-.55-.45-1-1-1H5c-.55 0-1 .45-1 1H2c-.55 0-1 .45-1 1v1c0 .55.45 1 1 1v9c0 .55.45 1 1 1h7c.55 0 1-.45 1-1V5c.55 0 1-.45 1-1V3c0-.55-.45-1-1-1zm-1 12H3V5h1v8h1V5h1v8h1V5h1v8h1V5h1v9zm1-10H2V3h9v1z"/></svg>
          </button>
</form>  </div>

  <div class="file-info">
      496 lines (391 sloc)
      <span class="file-info-divider"></span>
    20.5 KB
  </div>
</div>

    

  <div itemprop="text" class="blob-wrapper data type-batchfile">
      <table class="highlight tab-size js-file-line-container" data-tab-size="8">
      <tr>
        <td id="L1" class="blob-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-code blob-code-inner js-file-line"><span class="pl-k">@</span><span class="pl-k">echo</span> off</td>
      </tr>
      <tr>
        <td id="L2" class="blob-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L3" class="blob-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> hMSBuild - v1.2.2.62992 [ 3ee58c3 ]</span></td>
      </tr>
      <tr>
        <td id="L4" class="blob-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Copyright (c) 2017  Denis Kuzmin [ entry.reg@gmail.com ]</span></td>
      </tr>
      <tr>
        <td id="L5" class="blob-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> -</span></td>
      </tr>
      <tr>
        <td id="L6" class="blob-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Distributed under the MIT license</span></td>
      </tr>
      <tr>
        <td id="L7" class="blob-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> https://github.com/3F/hMSBuild</span></td>
      </tr>
      <tr>
        <td id="L8" class="blob-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L9" class="blob-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-code blob-code-inner js-file-line"><span class="pl-k">setlocal</span> enableDelayedExpansion</td>
      </tr>
      <tr>
        <td id="L10" class="blob-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L11" class="blob-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L12" class="blob-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> - - -</span></td>
      </tr>
      <tr>
        <td id="L13" class="blob-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Settings by default</span></td>
      </tr>
      <tr>
        <td id="L14" class="blob-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L15" class="blob-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">vswhereByDefault</span><span class="pl-k">=</span>1.0.62</td>
      </tr>
      <tr>
        <td id="L16" class="blob-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">vswhereCache</span><span class="pl-k">=</span><span class="pl-smi">%temp%</span>\hMSBuild_vswhere</td>
      </tr>
      <tr>
        <td id="L17" class="blob-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L18" class="blob-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a notamd64<span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L19" class="blob-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a novs<span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L20" class="blob-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a nonet<span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L21" class="blob-num js-line-number" data-line-number="21"></td>
        <td id="LC21" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a novswhere<span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L22" class="blob-num js-line-number" data-line-number="22"></td>
        <td id="LC22" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a nocachevswhere<span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L23" class="blob-num js-line-number" data-line-number="23"></td>
        <td id="LC23" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a hMSBuildDebug<span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L24" class="blob-num js-line-number" data-line-number="24"></td>
        <td id="LC24" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-pds">&quot;</span><span class="pl-smi">displayOnlyPath</span><span class="pl-k">=</span>&quot;</td>
      </tr>
      <tr>
        <td id="L25" class="blob-num js-line-number" data-line-number="25"></td>
        <td id="LC25" class="blob-code blob-code-inner js-file-line">set <span class="pl-s">&quot;</span><span class="pl-smi">vswVersion</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-ii"></span></span></td>
      </tr>
      <tr>
        <td id="L26" class="blob-num js-line-number" data-line-number="26"></td>
        <td id="LC26" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L27" class="blob-num js-line-number" data-line-number="27"></td>
        <td id="LC27" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">ERROR_SUCCESS</span><span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L28" class="blob-num js-line-number" data-line-number="28"></td>
        <td id="LC28" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">ERROR_FILE_NOT_FOUND</span><span class="pl-k">=</span><span class="pl-c1">2</span></td>
      </tr>
      <tr>
        <td id="L29" class="blob-num js-line-number" data-line-number="29"></td>
        <td id="LC29" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">ERROR_PATH_NOT_FOUND</span><span class="pl-k">=</span><span class="pl-c1">3</span></td>
      </tr>
      <tr>
        <td id="L30" class="blob-num js-line-number" data-line-number="30"></td>
        <td id="LC30" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L31" class="blob-num js-line-number" data-line-number="31"></td>
        <td id="LC31" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-pds">&quot;</span><span class="pl-smi">args</span><span class="pl-k">=</span><span class="pl-v">%*</span> <span class="pl-s">&quot;</span></td>
      </tr>
      <tr>
        <td id="L32" class="blob-num js-line-number" data-line-number="32"></td>
        <td id="LC32" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L33" class="blob-num js-line-number" data-line-number="33"></td>
        <td id="LC33" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L34" class="blob-num js-line-number" data-line-number="34"></td>
        <td id="LC34" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> - - -</span></td>
      </tr>
      <tr>
        <td id="L35" class="blob-num js-line-number" data-line-number="35"></td>
        <td id="LC35" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Help command</span></td>
      </tr>
      <tr>
        <td id="L36" class="blob-num js-line-number" data-line-number="36"></td>
        <td id="LC36" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L37" class="blob-num js-line-number" data-line-number="37"></td>
        <td id="LC37" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">_hl</span><span class="pl-k">=</span><span class="pl-smi">%args:<span class="pl-s">&quot;</span>=%</span></td>
      </tr>
      <tr>
        <td id="L38" class="blob-num js-line-number" data-line-number="38"></td>
        <td id="LC38" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">_hr</span><span class="pl-k">=</span><span class="pl-smi">%_hl%</span></td>
      </tr>
      <tr>
        <td id="L39" class="blob-num js-line-number" data-line-number="39"></td>
        <td id="LC39" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L40" class="blob-num js-line-number" data-line-number="40"></td>
        <td id="LC40" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">_hr</span><span class="pl-k">=</span><span class="pl-smi">%_hr:<span class="pl-s">-help </span>=%</span></td>
      </tr>
      <tr>
        <td id="L41" class="blob-num js-line-number" data-line-number="41"></td>
        <td id="LC41" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">_hr</span><span class="pl-k">=</span><span class="pl-smi">%_hr:<span class="pl-s">-h </span>=%</span></td>
      </tr>
      <tr>
        <td id="L42" class="blob-num js-line-number" data-line-number="42"></td>
        <td id="LC42" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">_hr</span><span class="pl-k">=</span><span class="pl-smi">%_hr:<span class="pl-s">-? </span>=%</span></td>
      </tr>
      <tr>
        <td id="L43" class="blob-num js-line-number" data-line-number="43"></td>
        <td id="LC43" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L44" class="blob-num js-line-number" data-line-number="44"></td>
        <td id="LC44" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">not</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%_hl%</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%_hr%</span><span class="pl-pds">&quot;</span></span> <span class="pl-k">goto</span> usage</td>
      </tr>
      <tr>
        <td id="L45" class="blob-num js-line-number" data-line-number="45"></td>
        <td id="LC45" class="blob-code blob-code-inner js-file-line"><span class="pl-k">goto</span> commands</td>
      </tr>
      <tr>
        <td id="L46" class="blob-num js-line-number" data-line-number="46"></td>
        <td id="LC46" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L47" class="blob-num js-line-number" data-line-number="47"></td>
        <td id="LC47" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">usage</span></td>
      </tr>
      <tr>
        <td id="L48" class="blob-num js-line-number" data-line-number="48"></td>
        <td id="LC48" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L49" class="blob-num js-line-number" data-line-number="49"></td>
        <td id="LC49" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L50" class="blob-num js-line-number" data-line-number="50"></td>
        <td id="LC50" class="blob-code blob-code-inner js-file-line"><span class="pl-k">@</span><span class="pl-k">echo</span> :: hMSBuild - v1.2.2.62992 [ 3ee58c3 ]</td>
      </tr>
      <tr>
        <td id="L51" class="blob-num js-line-number" data-line-number="51"></td>
        <td id="LC51" class="blob-code blob-code-inner js-file-line"><span class="pl-k">@</span><span class="pl-k">echo</span> Copyright (c) <span class="pl-c1">2017</span>  Denis Kuzmin [ entry.reg<span class="pl-k">@</span>gmail.com :: github.com/3F ]</td>
      </tr>
      <tr>
        <td id="L52" class="blob-num js-line-number" data-line-number="52"></td>
        <td id="LC52" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> Distributed under the MIT license</td>
      </tr>
      <tr>
        <td id="L53" class="blob-num js-line-number" data-line-number="53"></td>
        <td id="LC53" class="blob-code blob-code-inner js-file-line"><span class="pl-k">@</span><span class="pl-k">echo</span> https://github.com/3F/hMSBuild </td>
      </tr>
      <tr>
        <td id="L54" class="blob-num js-line-number" data-line-number="54"></td>
        <td id="LC54" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L55" class="blob-num js-line-number" data-line-number="55"></td>
        <td id="LC55" class="blob-code blob-code-inner js-file-line"><span class="pl-k">@</span><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L56" class="blob-num js-line-number" data-line-number="56"></td>
        <td id="LC56" class="blob-code blob-code-inner js-file-line"><span class="pl-k">@</span><span class="pl-k">echo</span> Usage: hMSBuild [args to hMSBuild] [args to msbuild.exe or GetNuTool core]</td>
      </tr>
      <tr>
        <td id="L57" class="blob-num js-line-number" data-line-number="57"></td>
        <td id="LC57" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> ------</td>
      </tr>
      <tr>
        <td id="L58" class="blob-num js-line-number" data-line-number="58"></td>
        <td id="LC58" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L59" class="blob-num js-line-number" data-line-number="59"></td>
        <td id="LC59" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> Arguments:</td>
      </tr>
      <tr>
        <td id="L60" class="blob-num js-line-number" data-line-number="60"></td>
        <td id="LC60" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> ----------</td>
      </tr>
      <tr>
        <td id="L61" class="blob-num js-line-number" data-line-number="61"></td>
        <td id="LC61" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -novswhere             - Do not search via vswhere.</td>
      </tr>
      <tr>
        <td id="L62" class="blob-num js-line-number" data-line-number="62"></td>
        <td id="LC62" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -novs                  - Disable searching from Visual Studio.</td>
      </tr>
      <tr>
        <td id="L63" class="blob-num js-line-number" data-line-number="63"></td>
        <td id="LC63" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -nonet                 - Disable searching from .NET Framework.</td>
      </tr>
      <tr>
        <td id="L64" class="blob-num js-line-number" data-line-number="64"></td>
        <td id="LC64" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -vswhere-version {num} - Specific version of vswhere. Where {num}:</td>
      </tr>
      <tr>
        <td id="L65" class="blob-num js-line-number" data-line-number="65"></td>
        <td id="LC65" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>                           * Versions: 1.0.50 ...</td>
      </tr>
      <tr>
        <td id="L66" class="blob-num js-line-number" data-line-number="66"></td>
        <td id="LC66" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>                           * Keywords: </td>
      </tr>
      <tr>
        <td id="L67" class="blob-num js-line-number" data-line-number="67"></td>
        <td id="LC67" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>                             `latest` to get latest available version; </td>
      </tr>
      <tr>
        <td id="L68" class="blob-num js-line-number" data-line-number="68"></td>
        <td id="LC68" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>                             `local`  to use only local versions: </td>
      </tr>
      <tr>
        <td id="L69" class="blob-num js-line-number" data-line-number="69"></td>
        <td id="LC69" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>                                      (.bat;.exe /or from +15.2.26418.1 VS-build);</td>
      </tr>
      <tr>
        <td id="L70" class="blob-num js-line-number" data-line-number="70"></td>
        <td id="LC70" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L71" class="blob-num js-line-number" data-line-number="71"></td>
        <td id="LC71" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -nocachevswhere        - Do not cache vswhere. Use this also for reset cache.</td>
      </tr>
      <tr>
        <td id="L72" class="blob-num js-line-number" data-line-number="72"></td>
        <td id="LC72" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -notamd64              - To use 32bit version of found msbuild.exe if it&#39;s possible.</td>
      </tr>
      <tr>
        <td id="L73" class="blob-num js-line-number" data-line-number="73"></td>
        <td id="LC73" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -eng                   - Try to use english language for all build messages.</td>
      </tr>
      <tr>
        <td id="L74" class="blob-num js-line-number" data-line-number="74"></td>
        <td id="LC74" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -GetNuTool {args}      - Access to GetNuTool core. https://github.com/3F/GetNuTool</td>
      </tr>
      <tr>
        <td id="L75" class="blob-num js-line-number" data-line-number="75"></td>
        <td id="LC75" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -only-path             - Only display fullpath to found MSBuild.</td>
      </tr>
      <tr>
        <td id="L76" class="blob-num js-line-number" data-line-number="76"></td>
        <td id="LC76" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -debug                 - To show additional information from hMSBuild.</td>
      </tr>
      <tr>
        <td id="L77" class="blob-num js-line-number" data-line-number="77"></td>
        <td id="LC77" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -version               - Display version of hMSBuild.</td>
      </tr>
      <tr>
        <td id="L78" class="blob-num js-line-number" data-line-number="78"></td>
        <td id="LC78" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>  -help                  - Display this help. Aliases: -help -h -?</td>
      </tr>
      <tr>
        <td id="L79" class="blob-num js-line-number" data-line-number="79"></td>
        <td id="LC79" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L80" class="blob-num js-line-number" data-line-number="80"></td>
        <td id="LC80" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>. </td>
      </tr>
      <tr>
        <td id="L81" class="blob-num js-line-number" data-line-number="81"></td>
        <td id="LC81" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> -------- </td>
      </tr>
      <tr>
        <td id="L82" class="blob-num js-line-number" data-line-number="82"></td>
        <td id="LC82" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> Samples:</td>
      </tr>
      <tr>
        <td id="L83" class="blob-num js-line-number" data-line-number="83"></td>
        <td id="LC83" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> -------- </td>
      </tr>
      <tr>
        <td id="L84" class="blob-num js-line-number" data-line-number="84"></td>
        <td id="LC84" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> hMSBuild -vswhere-version 1.0.50 -notamd64 <span class="pl-s"><span class="pl-pds">&quot;</span>Conari.sln<span class="pl-pds">&quot;</span></span> /t:Rebuild</td>
      </tr>
      <tr>
        <td id="L85" class="blob-num js-line-number" data-line-number="85"></td>
        <td id="LC85" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> hMSBuild -vswhere-version latest <span class="pl-s"><span class="pl-pds">&quot;</span>Conari.sln<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L86" class="blob-num js-line-number" data-line-number="86"></td>
        <td id="LC86" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L87" class="blob-num js-line-number" data-line-number="87"></td>
        <td id="LC87" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> hMSBuild -novswhere -novs -notamd64 <span class="pl-s"><span class="pl-pds">&quot;</span>Conari.sln<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L88" class="blob-num js-line-number" data-line-number="88"></td>
        <td id="LC88" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> hMSBuild -novs <span class="pl-s"><span class="pl-pds">&quot;</span>DllExport.sln<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L89" class="blob-num js-line-number" data-line-number="89"></td>
        <td id="LC89" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> hMSBuild vsSolutionBuildEvent.sln</td>
      </tr>
      <tr>
        <td id="L90" class="blob-num js-line-number" data-line-number="90"></td>
        <td id="LC90" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L91" class="blob-num js-line-number" data-line-number="91"></td>
        <td id="LC91" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> hMSBuild -GetNuTool -unpack</td>
      </tr>
      <tr>
        <td id="L92" class="blob-num js-line-number" data-line-number="92"></td>
        <td id="LC92" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> hMSBuild -GetNuTool /p:ngpackages=<span class="pl-s"><span class="pl-pds">&quot;</span>Conari;regXwild<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L93" class="blob-num js-line-number" data-line-number="93"></td>
        <td id="LC93" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L94" class="blob-num js-line-number" data-line-number="94"></td>
        <td id="LC94" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> <span class="pl-s"><span class="pl-pds">&quot;</span>hMSBuild -novs <span class="pl-pds">&quot;</span></span>DllExport.sln<span class="pl-s"><span class="pl-pds">&quot;</span> || goto err<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L95" class="blob-num js-line-number" data-line-number="95"></td>
        <td id="LC95" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L96" class="blob-num js-line-number" data-line-number="96"></td>
        <td id="LC96" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> ---------------------</td>
      </tr>
      <tr>
        <td id="L97" class="blob-num js-line-number" data-line-number="97"></td>
        <td id="LC97" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> Possible Error Codes: ERROR_FILE_NOT_FOUND (0x2), ERROR_PATH_NOT_FOUND (0x3), ERROR_SUCCESS (0x0)</td>
      </tr>
      <tr>
        <td id="L98" class="blob-num js-line-number" data-line-number="98"></td>
        <td id="LC98" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> ---------------------</td>
      </tr>
      <tr>
        <td id="L99" class="blob-num js-line-number" data-line-number="99"></td>
        <td id="LC99" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span>.</td>
      </tr>
      <tr>
        <td id="L100" class="blob-num js-line-number" data-line-number="100"></td>
        <td id="LC100" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L101" class="blob-num js-line-number" data-line-number="101"></td>
        <td id="LC101" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L102" class="blob-num js-line-number" data-line-number="102"></td>
        <td id="LC102" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L103" class="blob-num js-line-number" data-line-number="103"></td>
        <td id="LC103" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> - - -</span></td>
      </tr>
      <tr>
        <td id="L104" class="blob-num js-line-number" data-line-number="104"></td>
        <td id="LC104" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Handler of user commands</span></td>
      </tr>
      <tr>
        <td id="L105" class="blob-num js-line-number" data-line-number="105"></td>
        <td id="LC105" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L106" class="blob-num js-line-number" data-line-number="106"></td>
        <td id="LC106" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">commands</span></td>
      </tr>
      <tr>
        <td id="L107" class="blob-num js-line-number" data-line-number="107"></td>
        <td id="LC107" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L108" class="blob-num js-line-number" data-line-number="108"></td>
        <td id="LC108" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :isEmptyOrWhitespace args _is</td>
      </tr>
      <tr>
        <td id="L109" class="blob-num js-line-number" data-line-number="109"></td>
        <td id="LC109" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> [<span class="pl-smi">!_is!</span>]<span class="pl-k">==</span>[1] <span class="pl-k">goto</span> action</td>
      </tr>
      <tr>
        <td id="L110" class="blob-num js-line-number" data-line-number="110"></td>
        <td id="LC110" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L111" class="blob-num js-line-number" data-line-number="111"></td>
        <td id="LC111" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a idx<span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-k">set</span> <span class="pl-smi">cmdMax</span><span class="pl-k">=</span><span class="pl-c1">12</span></td>
      </tr>
      <tr>
        <td id="L112" class="blob-num js-line-number" data-line-number="112"></td>
        <td id="LC112" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">loopargs</span></td>
      </tr>
      <tr>
        <td id="L113" class="blob-num js-line-number" data-line-number="113"></td>
        <td id="LC113" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L114" class="blob-num js-line-number" data-line-number="114"></td>
        <td id="LC114" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">11</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-GetNuTool <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L115" class="blob-num js-line-number" data-line-number="115"></td>
        <td id="LC115" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L116" class="blob-num js-line-number" data-line-number="116"></td>
        <td id="LC116" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">goto</span> gntcall</td>
      </tr>
      <tr>
        <td id="L117" class="blob-num js-line-number" data-line-number="117"></td>
        <td id="LC117" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L118" class="blob-num js-line-number" data-line-number="118"></td>
        <td id="LC118" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L119" class="blob-num js-line-number" data-line-number="119"></td>
        <td id="LC119" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">11</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-novswhere <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L120" class="blob-num js-line-number" data-line-number="120"></td>
        <td id="LC120" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L121" class="blob-num js-line-number" data-line-number="121"></td>
        <td id="LC121" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-smi">novswhere</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L122" class="blob-num js-line-number" data-line-number="122"></td>
        <td id="LC122" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L123" class="blob-num js-line-number" data-line-number="123"></td>
        <td id="LC123" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L124" class="blob-num js-line-number" data-line-number="124"></td>
        <td id="LC124" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">16</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-nocachevswhere <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L125" class="blob-num js-line-number" data-line-number="125"></td>
        <td id="LC125" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L126" class="blob-num js-line-number" data-line-number="126"></td>
        <td id="LC126" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-smi">nocachevswhere</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L127" class="blob-num js-line-number" data-line-number="127"></td>
        <td id="LC127" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L128" class="blob-num js-line-number" data-line-number="128"></td>
        <td id="LC128" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L129" class="blob-num js-line-number" data-line-number="129"></td>
        <td id="LC129" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">6</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-novs <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L130" class="blob-num js-line-number" data-line-number="130"></td>
        <td id="LC130" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L131" class="blob-num js-line-number" data-line-number="131"></td>
        <td id="LC131" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-smi">novs</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L132" class="blob-num js-line-number" data-line-number="132"></td>
        <td id="LC132" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L133" class="blob-num js-line-number" data-line-number="133"></td>
        <td id="LC133" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L134" class="blob-num js-line-number" data-line-number="134"></td>
        <td id="LC134" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">7</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-nonet <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L135" class="blob-num js-line-number" data-line-number="135"></td>
        <td id="LC135" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L136" class="blob-num js-line-number" data-line-number="136"></td>
        <td id="LC136" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-smi">nonet</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L137" class="blob-num js-line-number" data-line-number="137"></td>
        <td id="LC137" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L138" class="blob-num js-line-number" data-line-number="138"></td>
        <td id="LC138" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L139" class="blob-num js-line-number" data-line-number="139"></td>
        <td id="LC139" class="blob-code blob-code-inner js-file-line">    <span class="pl-c"><span class="pl-c">::</span> backward compatibility - version 1.1</span></td>
      </tr>
      <tr>
        <td id="L140" class="blob-num js-line-number" data-line-number="140"></td>
        <td id="LC140" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">16</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-vswhereVersion <span class="pl-pds">&quot;</span></span> <span class="pl-k">set</span> <span class="pl-smi">_OrConditionVSWVer</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L141" class="blob-num js-line-number" data-line-number="141"></td>
        <td id="LC141" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">17</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-vswhere-version <span class="pl-pds">&quot;</span></span> <span class="pl-k">set</span> <span class="pl-smi">_OrConditionVSWVer</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L142" class="blob-num js-line-number" data-line-number="142"></td>
        <td id="LC142" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-k">defined</span> _OrConditionVSWVer (</td>
      </tr>
      <tr>
        <td id="L143" class="blob-num js-line-number" data-line-number="143"></td>
        <td id="LC143" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-pds">&quot;</span><span class="pl-smi">_OrConditionVSWVer</span><span class="pl-k">=</span>&quot;</td>
      </tr>
      <tr>
        <td id="L144" class="blob-num js-line-number" data-line-number="144"></td>
        <td id="LC144" class="blob-code blob-code-inner js-file-line">        call :popars <span class="pl-v">%1</span> &amp; shift</td>
      </tr>
      <tr>
        <td id="L145" class="blob-num js-line-number" data-line-number="145"></td>
        <td id="LC145" class="blob-code blob-code-inner js-file-line">        set vswVersion=<span class="pl-v">%2</span></td>
      </tr>
      <tr>
        <td id="L146" class="blob-num js-line-number" data-line-number="146"></td>
        <td id="LC146" class="blob-code blob-code-inner js-file-line">        echo selected new vswhere version: <span class="pl-smi">!vswVersion!</span></td>
      </tr>
      <tr>
        <td id="L147" class="blob-num js-line-number" data-line-number="147"></td>
        <td id="LC147" class="blob-code blob-code-inner js-file-line">        call :popars <span class="pl-v">%2</span> &amp; shift</td>
      </tr>
      <tr>
        <td id="L148" class="blob-num js-line-number" data-line-number="148"></td>
        <td id="LC148" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L149" class="blob-num js-line-number" data-line-number="149"></td>
        <td id="LC149" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L150" class="blob-num js-line-number" data-line-number="150"></td>
        <td id="LC150" class="blob-code blob-code-inner js-file-line">    if <span class="pl-s">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">10</span>!</span><span class="pl-pds">&quot;</span><span class="pl-smi">=</span><span class="pl-k">=</span>&quot;-notamd64 <span class="pl-s">&quot;</span> (</td>
      </tr>
      <tr>
        <td id="L151" class="blob-num js-line-number" data-line-number="151"></td>
        <td id="LC151" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L152" class="blob-num js-line-number" data-line-number="152"></td>
        <td id="LC152" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-smi">notamd64</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L153" class="blob-num js-line-number" data-line-number="153"></td>
        <td id="LC153" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L154" class="blob-num js-line-number" data-line-number="154"></td>
        <td id="LC154" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L155" class="blob-num js-line-number" data-line-number="155"></td>
        <td id="LC155" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">5</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-eng <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L156" class="blob-num js-line-number" data-line-number="156"></td>
        <td id="LC156" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L157" class="blob-num js-line-number" data-line-number="157"></td>
        <td id="LC157" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">chcp</span> <span class="pl-c1">437</span> <span class="pl-k">&gt;</span><span class="pl-c1">nul</span></td>
      </tr>
      <tr>
        <td id="L158" class="blob-num js-line-number" data-line-number="158"></td>
        <td id="LC158" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L159" class="blob-num js-line-number" data-line-number="159"></td>
        <td id="LC159" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L160" class="blob-num js-line-number" data-line-number="160"></td>
        <td id="LC160" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">11</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-only-path <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L161" class="blob-num js-line-number" data-line-number="161"></td>
        <td id="LC161" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L162" class="blob-num js-line-number" data-line-number="162"></td>
        <td id="LC162" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-smi">displayOnlyPath</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L163" class="blob-num js-line-number" data-line-number="163"></td>
        <td id="LC163" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L164" class="blob-num js-line-number" data-line-number="164"></td>
        <td id="LC164" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L165" class="blob-num js-line-number" data-line-number="165"></td>
        <td id="LC165" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">7</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-debug <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L166" class="blob-num js-line-number" data-line-number="166"></td>
        <td id="LC166" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :popars <span class="pl-v">%1</span> <span class="pl-k">&amp;</span> <span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L167" class="blob-num js-line-number" data-line-number="167"></td>
        <td id="LC167" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-smi">hMSBuildDebug</span><span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L168" class="blob-num js-line-number" data-line-number="168"></td>
        <td id="LC168" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L169" class="blob-num js-line-number" data-line-number="169"></td>
        <td id="LC169" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L170" class="blob-num js-line-number" data-line-number="170"></td>
        <td id="LC170" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!args:~<span class="pl-c1">0</span>,<span class="pl-c1">9</span>!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-version <span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L171" class="blob-num js-line-number" data-line-number="171"></td>
        <td id="LC171" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">@</span><span class="pl-k">echo</span> hMSBuild - v1.2.2.62992 [ 3ee58c3 ]</td>
      </tr>
      <tr>
        <td id="L172" class="blob-num js-line-number" data-line-number="172"></td>
        <td id="LC172" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L173" class="blob-num js-line-number" data-line-number="173"></td>
        <td id="LC173" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L174" class="blob-num js-line-number" data-line-number="174"></td>
        <td id="LC174" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L175" class="blob-num js-line-number" data-line-number="175"></td>
        <td id="LC175" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a <span class="pl-s"><span class="pl-pds">&quot;</span>idx<span class="pl-k">+=</span>1<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L176" class="blob-num js-line-number" data-line-number="176"></td>
        <td id="LC176" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-smi">!idx!</span> <span class="pl-k">LSS</span> <span class="pl-smi">%cmdMax%</span> <span class="pl-k">goto</span> loopargs</td>
      </tr>
      <tr>
        <td id="L177" class="blob-num js-line-number" data-line-number="177"></td>
        <td id="LC177" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L178" class="blob-num js-line-number" data-line-number="178"></td>
        <td id="LC178" class="blob-code blob-code-inner js-file-line"><span class="pl-k">goto</span> action</td>
      </tr>
      <tr>
        <td id="L179" class="blob-num js-line-number" data-line-number="179"></td>
        <td id="LC179" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L180" class="blob-num js-line-number" data-line-number="180"></td>
        <td id="LC180" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">popars</span></td>
      </tr>
      <tr>
        <td id="L181" class="blob-num js-line-number" data-line-number="181"></td>
        <td id="LC181" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">args</span><span class="pl-k">=</span>!<span class="pl-smi">!args:%<span class="pl-s">1 ^</span>=!</span>!</td>
      </tr>
      <tr>
        <td id="L182" class="blob-num js-line-number" data-line-number="182"></td>
        <td id="LC182" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :trim args</td>
      </tr>
      <tr>
        <td id="L183" class="blob-num js-line-number" data-line-number="183"></td>
        <td id="LC183" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-pds">&quot;</span><span class="pl-smi">args</span><span class="pl-k">=</span><span class="pl-smi">!args!</span> <span class="pl-s">&quot;</span></td>
      </tr>
      <tr>
        <td id="L184" class="blob-num js-line-number" data-line-number="184"></td>
        <td id="LC184" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L185" class="blob-num js-line-number" data-line-number="185"></td>
        <td id="LC185" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L186" class="blob-num js-line-number" data-line-number="186"></td>
        <td id="LC186" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> - - -</span></td>
      </tr>
      <tr>
        <td id="L187" class="blob-num js-line-number" data-line-number="187"></td>
        <td id="LC187" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Main logic of searching</span></td>
      </tr>
      <tr>
        <td id="L188" class="blob-num js-line-number" data-line-number="188"></td>
        <td id="LC188" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">action</span></td>
      </tr>
      <tr>
        <td id="L189" class="blob-num js-line-number" data-line-number="189"></td>
        <td id="LC189" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L190" class="blob-num js-line-number" data-line-number="190"></td>
        <td id="LC190" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!nocachevswhere!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L191" class="blob-num js-line-number" data-line-number="191"></td>
        <td id="LC191" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>resetting cache of vswhere<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L192" class="blob-num js-line-number" data-line-number="192"></td>
        <td id="LC192" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">rmdir</span> /S/Q <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%vswhereCache%</span><span class="pl-pds">&quot;</span></span> <span class="pl-c1">2</span><span class="pl-k">&gt;</span><span class="pl-c1">nul</span></td>
      </tr>
      <tr>
        <td id="L193" class="blob-num js-line-number" data-line-number="193"></td>
        <td id="LC193" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L194" class="blob-num js-line-number" data-line-number="194"></td>
        <td id="LC194" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L195" class="blob-num js-line-number" data-line-number="195"></td>
        <td id="LC195" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">not</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!novswhere!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> <span class="pl-k">if</span> <span class="pl-k">not</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!novs!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L196" class="blob-num js-line-number" data-line-number="196"></td>
        <td id="LC196" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :vswhere</td>
      </tr>
      <tr>
        <td id="L197" class="blob-num js-line-number" data-line-number="197"></td>
        <td id="LC197" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!ERRORLEVEL!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>0<span class="pl-pds">&quot;</span></span> <span class="pl-k">goto</span> runmsbuild</td>
      </tr>
      <tr>
        <td id="L198" class="blob-num js-line-number" data-line-number="198"></td>
        <td id="LC198" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L199" class="blob-num js-line-number" data-line-number="199"></td>
        <td id="LC199" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L200" class="blob-num js-line-number" data-line-number="200"></td>
        <td id="LC200" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">not</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!novs!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L201" class="blob-num js-line-number" data-line-number="201"></td>
        <td id="LC201" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :msbvsold</td>
      </tr>
      <tr>
        <td id="L202" class="blob-num js-line-number" data-line-number="202"></td>
        <td id="LC202" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!ERRORLEVEL!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>0<span class="pl-pds">&quot;</span></span> <span class="pl-k">goto</span> runmsbuild</td>
      </tr>
      <tr>
        <td id="L203" class="blob-num js-line-number" data-line-number="203"></td>
        <td id="LC203" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L204" class="blob-num js-line-number" data-line-number="204"></td>
        <td id="LC204" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L205" class="blob-num js-line-number" data-line-number="205"></td>
        <td id="LC205" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">not</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!nonet!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L206" class="blob-num js-line-number" data-line-number="206"></td>
        <td id="LC206" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :msbnetf</td>
      </tr>
      <tr>
        <td id="L207" class="blob-num js-line-number" data-line-number="207"></td>
        <td id="LC207" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!ERRORLEVEL!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>0<span class="pl-pds">&quot;</span></span> <span class="pl-k">goto</span> runmsbuild</td>
      </tr>
      <tr>
        <td id="L208" class="blob-num js-line-number" data-line-number="208"></td>
        <td id="LC208" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L209" class="blob-num js-line-number" data-line-number="209"></td>
        <td id="LC209" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L210" class="blob-num js-line-number" data-line-number="210"></td>
        <td id="LC210" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> MSBuild tools was not found. Try to use other settings. Use key `-help` for details.</td>
      </tr>
      <tr>
        <td id="L211" class="blob-num js-line-number" data-line-number="211"></td>
        <td id="LC211" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-smi">%ERROR_FILE_NOT_FOUND%</span></td>
      </tr>
      <tr>
        <td id="L212" class="blob-num js-line-number" data-line-number="212"></td>
        <td id="LC212" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L213" class="blob-num js-line-number" data-line-number="213"></td>
        <td id="LC213" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">runmsbuild</span></td>
      </tr>
      <tr>
        <td id="L214" class="blob-num js-line-number" data-line-number="214"></td>
        <td id="LC214" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L215" class="blob-num js-line-number" data-line-number="215"></td>
        <td id="LC215" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :isEmptyOrWhitespace msbuildPath _is</td>
      </tr>
      <tr>
        <td id="L216" class="blob-num js-line-number" data-line-number="216"></td>
        <td id="LC216" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> [<span class="pl-smi">!_is!</span>]<span class="pl-k">==</span>[1] (</td>
      </tr>
      <tr>
        <td id="L217" class="blob-num js-line-number" data-line-number="217"></td>
        <td id="LC217" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">echo</span> Something went wrong. Use `-debug` key for details.</td>
      </tr>
      <tr>
        <td id="L218" class="blob-num js-line-number" data-line-number="218"></td>
        <td id="LC218" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">exit</span> /B <span class="pl-smi">%ERROR_FILE_NOT_FOUND%</span></td>
      </tr>
      <tr>
        <td id="L219" class="blob-num js-line-number" data-line-number="219"></td>
        <td id="LC219" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L220" class="blob-num js-line-number" data-line-number="220"></td>
        <td id="LC220" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L221" class="blob-num js-line-number" data-line-number="221"></td>
        <td id="LC221" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">defined</span> displayOnlyPath (</td>
      </tr>
      <tr>
        <td id="L222" class="blob-num js-line-number" data-line-number="222"></td>
        <td id="LC222" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">echo</span> <span class="pl-smi">!msbuildPath!</span></td>
      </tr>
      <tr>
        <td id="L223" class="blob-num js-line-number" data-line-number="223"></td>
        <td id="LC223" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L224" class="blob-num js-line-number" data-line-number="224"></td>
        <td id="LC224" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L225" class="blob-num js-line-number" data-line-number="225"></td>
        <td id="LC225" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">xMSBuild</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!msbuildPath!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L226" class="blob-num js-line-number" data-line-number="226"></td>
        <td id="LC226" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L227" class="blob-num js-line-number" data-line-number="227"></td>
        <td id="LC227" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> hMSBuild: <span class="pl-smi">!xMSBuild!</span> </td>
      </tr>
      <tr>
        <td id="L228" class="blob-num js-line-number" data-line-number="228"></td>
        <td id="LC228" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>Arguments: <span class="pl-smi">!args!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L229" class="blob-num js-line-number" data-line-number="229"></td>
        <td id="LC229" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L230" class="blob-num js-line-number" data-line-number="230"></td>
        <td id="LC230" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">!xMSBuild!</span> <span class="pl-smi">!args!</span></td>
      </tr>
      <tr>
        <td id="L231" class="blob-num js-line-number" data-line-number="231"></td>
        <td id="LC231" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-smi">%ERRORLEVEL%</span></td>
      </tr>
      <tr>
        <td id="L232" class="blob-num js-line-number" data-line-number="232"></td>
        <td id="LC232" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L233" class="blob-num js-line-number" data-line-number="233"></td>
        <td id="LC233" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> - - -</span></td>
      </tr>
      <tr>
        <td id="L234" class="blob-num js-line-number" data-line-number="234"></td>
        <td id="LC234" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Tools from VS2017+</span></td>
      </tr>
      <tr>
        <td id="L235" class="blob-num js-line-number" data-line-number="235"></td>
        <td id="LC235" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">vswhere</span></td>
      </tr>
      <tr>
        <td id="L236" class="blob-num js-line-number" data-line-number="236"></td>
        <td id="LC236" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L237" class="blob-num js-line-number" data-line-number="237"></td>
        <td id="LC237" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>trying via vswhere...<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L238" class="blob-num js-line-number" data-line-number="238"></td>
        <td id="LC238" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L239" class="blob-num js-line-number" data-line-number="239"></td>
        <td id="LC239" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">defined</span> vswVersion (</td>
      </tr>
      <tr>
        <td id="L240" class="blob-num js-line-number" data-line-number="240"></td>
        <td id="LC240" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-k">not</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!vswVersion!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>local<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L241" class="blob-num js-line-number" data-line-number="241"></td>
        <td id="LC241" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :vswhereRemote</td>
      </tr>
      <tr>
        <td id="L242" class="blob-num js-line-number" data-line-number="242"></td>
        <td id="LC242" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :vswhereBin</td>
      </tr>
      <tr>
        <td id="L243" class="blob-num js-line-number" data-line-number="243"></td>
        <td id="LC243" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">exit</span> /B <span class="pl-smi">!ERRORLEVEL!</span></td>
      </tr>
      <tr>
        <td id="L244" class="blob-num js-line-number" data-line-number="244"></td>
        <td id="LC244" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L245" class="blob-num js-line-number" data-line-number="245"></td>
        <td id="LC245" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L246" class="blob-num js-line-number" data-line-number="246"></td>
        <td id="LC246" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L247" class="blob-num js-line-number" data-line-number="247"></td>
        <td id="LC247" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :vswhereLocal</td>
      </tr>
      <tr>
        <td id="L248" class="blob-num js-line-number" data-line-number="248"></td>
        <td id="LC248" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!ERRORLEVEL!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%ERROR_PATH_NOT_FOUND%</span><span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L249" class="blob-num js-line-number" data-line-number="249"></td>
        <td id="LC249" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!vswVersion!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>local<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L250" class="blob-num js-line-number" data-line-number="250"></td>
        <td id="LC250" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">exit</span> /B <span class="pl-smi">%ERROR_PATH_NOT_FOUND%</span></td>
      </tr>
      <tr>
        <td id="L251" class="blob-num js-line-number" data-line-number="251"></td>
        <td id="LC251" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L252" class="blob-num js-line-number" data-line-number="252"></td>
        <td id="LC252" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :vswhereRemote</td>
      </tr>
      <tr>
        <td id="L253" class="blob-num js-line-number" data-line-number="253"></td>
        <td id="LC253" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L254" class="blob-num js-line-number" data-line-number="254"></td>
        <td id="LC254" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :vswhereBin</td>
      </tr>
      <tr>
        <td id="L255" class="blob-num js-line-number" data-line-number="255"></td>
        <td id="LC255" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-smi">!ERRORLEVEL!</span></td>
      </tr>
      <tr>
        <td id="L256" class="blob-num js-line-number" data-line-number="256"></td>
        <td id="LC256" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L257" class="blob-num js-line-number" data-line-number="257"></td>
        <td id="LC257" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">vswhereLocal</span></td>
      </tr>
      <tr>
        <td id="L258" class="blob-num js-line-number" data-line-number="258"></td>
        <td id="LC258" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L259" class="blob-num js-line-number" data-line-number="259"></td>
        <td id="LC259" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Only with +15.2.26418.1 VS-build</span></td>
      </tr>
      <tr>
        <td id="L260" class="blob-num js-line-number" data-line-number="260"></td>
        <td id="LC260" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> https://github.com/3F/hMSBuild/issues/1</span></td>
      </tr>
      <tr>
        <td id="L261" class="blob-num js-line-number" data-line-number="261"></td>
        <td id="LC261" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L262" class="blob-num js-line-number" data-line-number="262"></td>
        <td id="LC262" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">exist</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-v">%~dp0</span>vswhere.bat<span class="pl-pds">&quot;</span></span> <span class="pl-k">set</span> <span class="pl-smi">vswbin</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-v">%~dp0</span>vswhere<span class="pl-pds">&quot;</span></span> <span class="pl-k">&amp;</span> <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L263" class="blob-num js-line-number" data-line-number="263"></td>
        <td id="LC263" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">exist</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-v">%~dp0</span>vswhere.exe<span class="pl-pds">&quot;</span></span> <span class="pl-k">set</span> <span class="pl-smi">vswbin</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-v">%~dp0</span>vswhere<span class="pl-pds">&quot;</span></span> <span class="pl-k">&amp;</span> <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L264" class="blob-num js-line-number" data-line-number="264"></td>
        <td id="LC264" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L265" class="blob-num js-line-number" data-line-number="265"></td>
        <td id="LC265" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">rlocalp</span><span class="pl-k">=</span>Microsoft Visual Studio\Installer</td>
      </tr>
      <tr>
        <td id="L266" class="blob-num js-line-number" data-line-number="266"></td>
        <td id="LC266" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">exist</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%ProgramFiles(x86)%</span>\<span class="pl-smi">!rlocalp!</span><span class="pl-pds">&quot;</span></span> <span class="pl-k">set</span> <span class="pl-smi">vswbin</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%ProgramFiles(x86)%</span>\<span class="pl-smi">!rlocalp!</span>\vswhere<span class="pl-pds">&quot;</span></span> <span class="pl-k">&amp;</span> <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L267" class="blob-num js-line-number" data-line-number="267"></td>
        <td id="LC267" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">exist</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%ProgramFiles%</span>\<span class="pl-smi">!rlocalp!</span><span class="pl-pds">&quot;</span></span> <span class="pl-k">set</span> <span class="pl-smi">vswbin</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%ProgramFiles%</span>\<span class="pl-smi">!rlocalp!</span>\vswhere<span class="pl-pds">&quot;</span></span> <span class="pl-k">&amp;</span> <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L268" class="blob-num js-line-number" data-line-number="268"></td>
        <td id="LC268" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L269" class="blob-num js-line-number" data-line-number="269"></td>
        <td id="LC269" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>local vswhere is not found.<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L270" class="blob-num js-line-number" data-line-number="270"></td>
        <td id="LC270" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-smi">%ERROR_PATH_NOT_FOUND%</span></td>
      </tr>
      <tr>
        <td id="L271" class="blob-num js-line-number" data-line-number="271"></td>
        <td id="LC271" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L272" class="blob-num js-line-number" data-line-number="272"></td>
        <td id="LC272" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">vswhereRemote</span></td>
      </tr>
      <tr>
        <td id="L273" class="blob-num js-line-number" data-line-number="273"></td>
        <td id="LC273" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L274" class="blob-num js-line-number" data-line-number="274"></td>
        <td id="LC274" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!nocachevswhere!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L275" class="blob-num js-line-number" data-line-number="275"></td>
        <td id="LC275" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">tvswhere</span><span class="pl-k">=</span><span class="pl-smi">%temp%</span>\<span class="pl-smi">%random%%random%</span>vswhere</td>
      </tr>
      <tr>
        <td id="L276" class="blob-num js-line-number" data-line-number="276"></td>
        <td id="LC276" class="blob-code blob-code-inner js-file-line">) <span class="pl-k">else</span> (</td>
      </tr>
      <tr>
        <td id="L277" class="blob-num js-line-number" data-line-number="277"></td>
        <td id="LC277" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">tvswhere</span><span class="pl-k">=</span><span class="pl-smi">%vswhereCache%</span></td>
      </tr>
      <tr>
        <td id="L278" class="blob-num js-line-number" data-line-number="278"></td>
        <td id="LC278" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L279" class="blob-num js-line-number" data-line-number="279"></td>
        <td id="LC279" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L280" class="blob-num js-line-number" data-line-number="280"></td>
        <td id="LC280" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>tvswhere: <span class="pl-smi">!tvswhere!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L281" class="blob-num js-line-number" data-line-number="281"></td>
        <td id="LC281" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L282" class="blob-num js-line-number" data-line-number="282"></td>
        <td id="LC282" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!vswVersion!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>latest<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L283" class="blob-num js-line-number" data-line-number="283"></td>
        <td id="LC283" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">vswpkg</span><span class="pl-k">=</span>vswhere</td>
      </tr>
      <tr>
        <td id="L284" class="blob-num js-line-number" data-line-number="284"></td>
        <td id="LC284" class="blob-code blob-code-inner js-file-line">) <span class="pl-k">else</span> (</td>
      </tr>
      <tr>
        <td id="L285" class="blob-num js-line-number" data-line-number="285"></td>
        <td id="LC285" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">vswpkg</span><span class="pl-k">=</span>vswhere/<span class="pl-smi">!vswVersion!</span></td>
      </tr>
      <tr>
        <td id="L286" class="blob-num js-line-number" data-line-number="286"></td>
        <td id="LC286" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L287" class="blob-num js-line-number" data-line-number="287"></td>
        <td id="LC287" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L288" class="blob-num js-line-number" data-line-number="288"></td>
        <td id="LC288" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>vswpkg: <span class="pl-smi">!vswpkg!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L289" class="blob-num js-line-number" data-line-number="289"></td>
        <td id="LC289" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L290" class="blob-num js-line-number" data-line-number="290"></td>
        <td id="LC290" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!hMSBuildDebug!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L291" class="blob-num js-line-number" data-line-number="291"></td>
        <td id="LC291" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :gntpoint /p:ngpackages=<span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!vswpkg!</span>:vswhere<span class="pl-pds">&quot;</span></span> /p:ngpath=<span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!tvswhere!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L292" class="blob-num js-line-number" data-line-number="292"></td>
        <td id="LC292" class="blob-code blob-code-inner js-file-line">) <span class="pl-k">else</span> (</td>
      </tr>
      <tr>
        <td id="L293" class="blob-num js-line-number" data-line-number="293"></td>
        <td id="LC293" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :gntpoint /p:ngpackages=<span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!vswpkg!</span>:vswhere<span class="pl-pds">&quot;</span></span> /p:ngpath=<span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!tvswhere!</span><span class="pl-pds">&quot;</span></span> <span class="pl-k">&gt;</span><span class="pl-c1">nul</span></td>
      </tr>
      <tr>
        <td id="L294" class="blob-num js-line-number" data-line-number="294"></td>
        <td id="LC294" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L295" class="blob-num js-line-number" data-line-number="295"></td>
        <td id="LC295" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">vswbin</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!tvswhere!</span>\vswhere\tools\vswhere<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L296" class="blob-num js-line-number" data-line-number="296"></td>
        <td id="LC296" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L297" class="blob-num js-line-number" data-line-number="297"></td>
        <td id="LC297" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L298" class="blob-num js-line-number" data-line-number="298"></td>
        <td id="LC298" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L299" class="blob-num js-line-number" data-line-number="299"></td>
        <td id="LC299" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">vswhereBin</span></td>
      </tr>
      <tr>
        <td id="L300" class="blob-num js-line-number" data-line-number="300"></td>
        <td id="LC300" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>vswbin: <span class="pl-pds">&quot;</span></span><span class="pl-smi">!vswbin!</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L301" class="blob-num js-line-number" data-line-number="301"></td>
        <td id="LC301" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L302" class="blob-num js-line-number" data-line-number="302"></td>
        <td id="LC302" class="blob-code blob-code-inner js-file-line"><span class="pl-k">for</span> /f <span class="pl-s"><span class="pl-pds">&quot;</span>usebackq tokens=1* delims=: <span class="pl-pds">&quot;</span></span> <span class="pl-cce">%%</span>a in (`<span class="pl-smi">!vswbin!</span> -latest -requires Microsoft.Component.MSBuild`) do (</td>
      </tr>
      <tr>
        <td id="L303" class="blob-num js-line-number" data-line-number="303"></td>
        <td id="LC303" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> /i <span class="pl-s"><span class="pl-pds">&quot;</span>%<span class="pl-smi">%a&quot;==&quot;installationPath&quot; set vspath=%</span>%b<span class="pl-ii"></span></span></td>
      </tr>
      <tr>
        <td id="L304" class="blob-num js-line-number" data-line-number="304"></td>
        <td id="LC304" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> /i <span class="pl-s"><span class="pl-pds">&quot;</span>%<span class="pl-smi">%a&quot;==&quot;installationVersion&quot; set vsver=%</span>%b<span class="pl-ii"></span></span></td>
      </tr>
      <tr>
        <td id="L305" class="blob-num js-line-number" data-line-number="305"></td>
        <td id="LC305" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L306" class="blob-num js-line-number" data-line-number="306"></td>
        <td id="LC306" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L307" class="blob-num js-line-number" data-line-number="307"></td>
        <td id="LC307" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>vspath: <span class="pl-smi">!vspath!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L308" class="blob-num js-line-number" data-line-number="308"></td>
        <td id="LC308" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>vsver: <span class="pl-smi">!vsver!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L309" class="blob-num js-line-number" data-line-number="309"></td>
        <td id="LC309" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L310" class="blob-num js-line-number" data-line-number="310"></td>
        <td id="LC310" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">defined</span> tvswhere (</td>
      </tr>
      <tr>
        <td id="L311" class="blob-num js-line-number" data-line-number="311"></td>
        <td id="LC311" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!nocachevswhere!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L312" class="blob-num js-line-number" data-line-number="312"></td>
        <td id="LC312" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>reset vswhere<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L313" class="blob-num js-line-number" data-line-number="313"></td>
        <td id="LC313" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">rmdir</span> /S/Q <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!tvswhere!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L314" class="blob-num js-line-number" data-line-number="314"></td>
        <td id="LC314" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L315" class="blob-num js-line-number" data-line-number="315"></td>
        <td id="LC315" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L316" class="blob-num js-line-number" data-line-number="316"></td>
        <td id="LC316" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L317" class="blob-num js-line-number" data-line-number="317"></td>
        <td id="LC317" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> [<span class="pl-smi">!vsver!</span>]<span class="pl-k">==</span>[] (</td>
      </tr>
      <tr>
        <td id="L318" class="blob-num js-line-number" data-line-number="318"></td>
        <td id="LC318" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>VS2017+ was not found via vswhere<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L319" class="blob-num js-line-number" data-line-number="319"></td>
        <td id="LC319" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">exit</span> /B <span class="pl-smi">%ERROR_PATH_NOT_FOUND%</span></td>
      </tr>
      <tr>
        <td id="L320" class="blob-num js-line-number" data-line-number="320"></td>
        <td id="LC320" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L321" class="blob-num js-line-number" data-line-number="321"></td>
        <td id="LC321" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L322" class="blob-num js-line-number" data-line-number="322"></td>
        <td id="LC322" class="blob-code blob-code-inner js-file-line"><span class="pl-k">for</span> /f <span class="pl-s"><span class="pl-pds">&quot;</span>tokens=1,2 delims=.<span class="pl-pds">&quot;</span></span> <span class="pl-cce">%%</span>a in (<span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!vsver!</span><span class="pl-pds">&quot;</span></span>) do (</td>
      </tr>
      <tr>
        <td id="L323" class="blob-num js-line-number" data-line-number="323"></td>
        <td id="LC323" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">vsver</span><span class="pl-k">=</span><span class="pl-cce">%%</span>a.0</td>
      </tr>
      <tr>
        <td id="L324" class="blob-num js-line-number" data-line-number="324"></td>
        <td id="LC324" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L325" class="blob-num js-line-number" data-line-number="325"></td>
        <td id="LC325" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">msbuildPath</span><span class="pl-k">=</span><span class="pl-smi">!vspath!</span>\MSBuild\<span class="pl-smi">!vsver!</span>\Bin</td>
      </tr>
      <tr>
        <td id="L326" class="blob-num js-line-number" data-line-number="326"></td>
        <td id="LC326" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L327" class="blob-num js-line-number" data-line-number="327"></td>
        <td id="LC327" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>found path to msbuild: <span class="pl-smi">!msbuildPath!</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L328" class="blob-num js-line-number" data-line-number="328"></td>
        <td id="LC328" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L329" class="blob-num js-line-number" data-line-number="329"></td>
        <td id="LC329" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">exist</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!msbuildPath!</span>\amd64<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L330" class="blob-num js-line-number" data-line-number="330"></td>
        <td id="LC330" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>found /amd64<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L331" class="blob-num js-line-number" data-line-number="331"></td>
        <td id="LC331" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">msbuildPath</span><span class="pl-k">=</span><span class="pl-smi">!msbuildPath!</span>\amd64</td>
      </tr>
      <tr>
        <td id="L332" class="blob-num js-line-number" data-line-number="332"></td>
        <td id="LC332" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L333" class="blob-num js-line-number" data-line-number="333"></td>
        <td id="LC333" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :msbuildfind </td>
      </tr>
      <tr>
        <td id="L334" class="blob-num js-line-number" data-line-number="334"></td>
        <td id="LC334" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L335" class="blob-num js-line-number" data-line-number="335"></td>
        <td id="LC335" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L336" class="blob-num js-line-number" data-line-number="336"></td>
        <td id="LC336" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> - - -</span></td>
      </tr>
      <tr>
        <td id="L337" class="blob-num js-line-number" data-line-number="337"></td>
        <td id="LC337" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Tools from Visual Studio - 2015, 2013, ...</span></td>
      </tr>
      <tr>
        <td id="L338" class="blob-num js-line-number" data-line-number="338"></td>
        <td id="LC338" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">msbvsold</span></td>
      </tr>
      <tr>
        <td id="L339" class="blob-num js-line-number" data-line-number="339"></td>
        <td id="LC339" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>trying via MSBuild tools from Visual Studio - 2015, 2013, ...<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L340" class="blob-num js-line-number" data-line-number="340"></td>
        <td id="LC340" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L341" class="blob-num js-line-number" data-line-number="341"></td>
        <td id="LC341" class="blob-code blob-code-inner js-file-line"><span class="pl-k">for</span> <span class="pl-cce">%%</span>v in (14.0, 12.0) do (</td>
      </tr>
      <tr>
        <td id="L342" class="blob-num js-line-number" data-line-number="342"></td>
        <td id="LC342" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :rtools <span class="pl-cce">%%</span>v Y <span class="pl-k">&amp;</span> <span class="pl-k">if</span> [<span class="pl-smi">!Y!</span>]<span class="pl-k">==</span>[1] <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L343" class="blob-num js-line-number" data-line-number="343"></td>
        <td id="LC343" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L344" class="blob-num js-line-number" data-line-number="344"></td>
        <td id="LC344" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>msbvsold: unfortunately we didn&#39;t find anything.<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L345" class="blob-num js-line-number" data-line-number="345"></td>
        <td id="LC345" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-smi">%ERROR_FILE_NOT_FOUND%</span></td>
      </tr>
      <tr>
        <td id="L346" class="blob-num js-line-number" data-line-number="346"></td>
        <td id="LC346" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L347" class="blob-num js-line-number" data-line-number="347"></td>
        <td id="LC347" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> - - -</span></td>
      </tr>
      <tr>
        <td id="L348" class="blob-num js-line-number" data-line-number="348"></td>
        <td id="LC348" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Tools from .NET Framework - .net 4.0, ...</span></td>
      </tr>
      <tr>
        <td id="L349" class="blob-num js-line-number" data-line-number="349"></td>
        <td id="LC349" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">msbnetf</span></td>
      </tr>
      <tr>
        <td id="L350" class="blob-num js-line-number" data-line-number="350"></td>
        <td id="LC350" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L351" class="blob-num js-line-number" data-line-number="351"></td>
        <td id="LC351" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>trying via MSBuild tools from .NET Framework - .net 4.0, ...<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L352" class="blob-num js-line-number" data-line-number="352"></td>
        <td id="LC352" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L353" class="blob-num js-line-number" data-line-number="353"></td>
        <td id="LC353" class="blob-code blob-code-inner js-file-line"><span class="pl-k">for</span> <span class="pl-cce">%%</span>v in (4.0, 3.5, 2.0) do (</td>
      </tr>
      <tr>
        <td id="L354" class="blob-num js-line-number" data-line-number="354"></td>
        <td id="LC354" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :rtools <span class="pl-cce">%%</span>v Y <span class="pl-k">&amp;</span> <span class="pl-k">if</span> [<span class="pl-smi">!Y!</span>]<span class="pl-k">==</span>[1] <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L355" class="blob-num js-line-number" data-line-number="355"></td>
        <td id="LC355" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L356" class="blob-num js-line-number" data-line-number="356"></td>
        <td id="LC356" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>msbnetf: unfortunately we didn&#39;t find anything.<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L357" class="blob-num js-line-number" data-line-number="357"></td>
        <td id="LC357" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-smi">%ERROR_FILE_NOT_FOUND%</span></td>
      </tr>
      <tr>
        <td id="L358" class="blob-num js-line-number" data-line-number="358"></td>
        <td id="LC358" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L359" class="blob-num js-line-number" data-line-number="359"></td>
        <td id="LC359" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">rtools</span></td>
      </tr>
      <tr>
        <td id="L360" class="blob-num js-line-number" data-line-number="360"></td>
        <td id="LC360" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>checking of version: <span class="pl-v">%1</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L361" class="blob-num js-line-number" data-line-number="361"></td>
        <td id="LC361" class="blob-code blob-code-inner js-file-line">    </td>
      </tr>
      <tr>
        <td id="L362" class="blob-num js-line-number" data-line-number="362"></td>
        <td id="LC362" class="blob-code blob-code-inner js-file-line"><span class="pl-k">for</span> /F <span class="pl-s"><span class="pl-pds">&quot;</span>usebackq tokens=2* skip=2<span class="pl-pds">&quot;</span></span> <span class="pl-cce">%%</span>a in (</td>
      </tr>
      <tr>
        <td id="L363" class="blob-num js-line-number" data-line-number="363"></td>
        <td id="LC363" class="blob-code blob-code-inner js-file-line">    `reg <span class="pl-k">query</span> <span class="pl-s"><span class="pl-pds">&quot;</span>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSBuild\ToolsVersions\<span class="pl-v">%1</span><span class="pl-pds">&quot;</span></span> /v MSBuildToolsPath 2<span class="pl-cce">^&gt;</span> <span class="pl-c1">nul</span>`</td>
      </tr>
      <tr>
        <td id="L364" class="blob-num js-line-number" data-line-number="364"></td>
        <td id="LC364" class="blob-code blob-code-inner js-file-line">) do <span class="pl-k">if</span> <span class="pl-k">exist</span> <span class="pl-cce">%%</span>b (</td>
      </tr>
      <tr>
        <td id="L365" class="blob-num js-line-number" data-line-number="365"></td>
        <td id="LC365" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>found: %%b<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L366" class="blob-num js-line-number" data-line-number="366"></td>
        <td id="LC366" class="blob-code blob-code-inner js-file-line">        </td>
      </tr>
      <tr>
        <td id="L367" class="blob-num js-line-number" data-line-number="367"></td>
        <td id="LC367" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">msbuildPath</span><span class="pl-k">=</span><span class="pl-cce">%%</span>b</td>
      </tr>
      <tr>
        <td id="L368" class="blob-num js-line-number" data-line-number="368"></td>
        <td id="LC368" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :msbuildfind</td>
      </tr>
      <tr>
        <td id="L369" class="blob-num js-line-number" data-line-number="369"></td>
        <td id="LC369" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> /a %2<span class="pl-k">=</span><span class="pl-c1">1</span></td>
      </tr>
      <tr>
        <td id="L370" class="blob-num js-line-number" data-line-number="370"></td>
        <td id="LC370" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L371" class="blob-num js-line-number" data-line-number="371"></td>
        <td id="LC371" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L372" class="blob-num js-line-number" data-line-number="372"></td>
        <td id="LC372" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> /a %2<span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L373" class="blob-num js-line-number" data-line-number="373"></td>
        <td id="LC373" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L374" class="blob-num js-line-number" data-line-number="374"></td>
        <td id="LC374" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L375" class="blob-num js-line-number" data-line-number="375"></td>
        <td id="LC375" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">gntcall</span></td>
      </tr>
      <tr>
        <td id="L376" class="blob-num js-line-number" data-line-number="376"></td>
        <td id="LC376" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>direct access to GetNuTool...<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L377" class="blob-num js-line-number" data-line-number="377"></td>
        <td id="LC377" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :gntpoint <span class="pl-smi">!args!</span></td>
      </tr>
      <tr>
        <td id="L378" class="blob-num js-line-number" data-line-number="378"></td>
        <td id="LC378" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L379" class="blob-num js-line-number" data-line-number="379"></td>
        <td id="LC379" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L380" class="blob-num js-line-number" data-line-number="380"></td>
        <td id="LC380" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">msbuildfind</span></td>
      </tr>
      <tr>
        <td id="L381" class="blob-num js-line-number" data-line-number="381"></td>
        <td id="LC381" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L382" class="blob-num js-line-number" data-line-number="382"></td>
        <td id="LC382" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">msbuildPath</span><span class="pl-k">=</span><span class="pl-smi">!msbuildPath!</span>\MSBuild.exe</td>
      </tr>
      <tr>
        <td id="L383" class="blob-num js-line-number" data-line-number="383"></td>
        <td id="LC383" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L384" class="blob-num js-line-number" data-line-number="384"></td>
        <td id="LC384" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">not</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!notamd64!</span><span class="pl-pds">&quot;</span></span> <span class="pl-k">==</span> <span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L385" class="blob-num js-line-number" data-line-number="385"></td>
        <td id="LC385" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L386" class="blob-num js-line-number" data-line-number="386"></td>
        <td id="LC386" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L387" class="blob-num js-line-number" data-line-number="387"></td>
        <td id="LC387" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L388" class="blob-num js-line-number" data-line-number="388"></td>
        <td id="LC388" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> 7z &amp; amd64\msbuild - https://github.com/3F/vsSolutionBuildEvent/issues/38</span></td>
      </tr>
      <tr>
        <td id="L389" class="blob-num js-line-number" data-line-number="389"></td>
        <td id="LC389" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">_amd</span><span class="pl-k">=</span><span class="pl-smi">!msbuildPath:<span class="pl-s">Framework64</span>=<span class="pl-s">Framework</span>!</span></td>
      </tr>
      <tr>
        <td id="L390" class="blob-num js-line-number" data-line-number="390"></td>
        <td id="LC390" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">_amd</span><span class="pl-k">=</span><span class="pl-smi">!_amd:<span class="pl-s">amd64</span>=!</span></td>
      </tr>
      <tr>
        <td id="L391" class="blob-num js-line-number" data-line-number="391"></td>
        <td id="LC391" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L392" class="blob-num js-line-number" data-line-number="392"></td>
        <td id="LC392" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">exist</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!_amd!</span><span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L393" class="blob-num js-line-number" data-line-number="393"></td>
        <td id="LC393" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>Return 32bit version of MSBuild.exe because you wanted this via -notamd64<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L394" class="blob-num js-line-number" data-line-number="394"></td>
        <td id="LC394" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">msbuildPath</span><span class="pl-k">=</span><span class="pl-smi">!_amd!</span></td>
      </tr>
      <tr>
        <td id="L395" class="blob-num js-line-number" data-line-number="395"></td>
        <td id="LC395" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L396" class="blob-num js-line-number" data-line-number="396"></td>
        <td id="LC396" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L397" class="blob-num js-line-number" data-line-number="397"></td>
        <td id="LC397" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L398" class="blob-num js-line-number" data-line-number="398"></td>
        <td id="LC398" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :dbgprint <span class="pl-s"><span class="pl-pds">&quot;</span>We know that 32bit version of MSBuild.exe is important for you, but we found only this.<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L399" class="blob-num js-line-number" data-line-number="399"></td>
        <td id="LC399" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L400" class="blob-num js-line-number" data-line-number="400"></td>
        <td id="LC400" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L401" class="blob-num js-line-number" data-line-number="401"></td>
        <td id="LC401" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> =</span></td>
      </tr>
      <tr>
        <td id="L402" class="blob-num js-line-number" data-line-number="402"></td>
        <td id="LC402" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L403" class="blob-num js-line-number" data-line-number="403"></td>
        <td id="LC403" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">dbgprint</span></td>
      </tr>
      <tr>
        <td id="L404" class="blob-num js-line-number" data-line-number="404"></td>
        <td id="LC404" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">!hMSBuildDebug!</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>1<span class="pl-pds">&quot;</span></span> (</td>
      </tr>
      <tr>
        <td id="L405" class="blob-num js-line-number" data-line-number="405"></td>
        <td id="LC405" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">msgfmt</span><span class="pl-k">=</span><span class="pl-v">%1</span></td>
      </tr>
      <tr>
        <td id="L406" class="blob-num js-line-number" data-line-number="406"></td>
        <td id="LC406" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">msgfmt</span><span class="pl-k">=</span><span class="pl-smi">!msgfmt:~<span class="pl-c1">0</span>,<span class="pl-c1">-1</span>!</span> </td>
      </tr>
      <tr>
        <td id="L407" class="blob-num js-line-number" data-line-number="407"></td>
        <td id="LC407" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">set</span> <span class="pl-smi">msgfmt</span><span class="pl-k">=</span><span class="pl-smi">!msgfmt:~<span class="pl-c1">1</span>!</span></td>
      </tr>
      <tr>
        <td id="L408" class="blob-num js-line-number" data-line-number="408"></td>
        <td id="LC408" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">echo</span>.[<span class="pl-smi">%TIME%</span> ] <span class="pl-smi">!msgfmt!</span></td>
      </tr>
      <tr>
        <td id="L409" class="blob-num js-line-number" data-line-number="409"></td>
        <td id="LC409" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L410" class="blob-num js-line-number" data-line-number="410"></td>
        <td id="LC410" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L411" class="blob-num js-line-number" data-line-number="411"></td>
        <td id="LC411" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L412" class="blob-num js-line-number" data-line-number="412"></td>
        <td id="LC412" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">trim</span></td>
      </tr>
      <tr>
        <td id="L413" class="blob-num js-line-number" data-line-number="413"></td>
        <td id="LC413" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Usage: call :trim variable</span></td>
      </tr>
      <tr>
        <td id="L414" class="blob-num js-line-number" data-line-number="414"></td>
        <td id="LC414" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :_v <span class="pl-cce">%%</span><span class="pl-v">%1</span><span class="pl-cce">%%</span></td>
      </tr>
      <tr>
        <td id="L415" class="blob-num js-line-number" data-line-number="415"></td>
        <td id="LC415" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-v">%1</span>=<span class="pl-smi">%_trimv%</span></td>
      </tr>
      <tr>
        <td id="L416" class="blob-num js-line-number" data-line-number="416"></td>
        <td id="LC416" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L417" class="blob-num js-line-number" data-line-number="417"></td>
        <td id="LC417" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">_v</span></td>
      </tr>
      <tr>
        <td id="L418" class="blob-num js-line-number" data-line-number="418"></td>
        <td id="LC418" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-pds">&quot;</span><span class="pl-smi">_trimv</span><span class="pl-k">=</span><span class="pl-v">%*</span><span class="pl-s">&quot;</span></td>
      </tr>
      <tr>
        <td id="L419" class="blob-num js-line-number" data-line-number="419"></td>
        <td id="LC419" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L420" class="blob-num js-line-number" data-line-number="420"></td>
        <td id="LC420" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L421" class="blob-num js-line-number" data-line-number="421"></td>
        <td id="LC421" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">isEmptyOrWhitespace</span></td>
      </tr>
      <tr>
        <td id="L422" class="blob-num js-line-number" data-line-number="422"></td>
        <td id="LC422" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Usage: call :isEmptyOrWhitespace input output(1/0)</span></td>
      </tr>
      <tr>
        <td id="L423" class="blob-num js-line-number" data-line-number="423"></td>
        <td id="LC423" class="blob-code blob-code-inner js-file-line"><span class="pl-k">setlocal</span> enableDelayedExpansion</td>
      </tr>
      <tr>
        <td id="L424" class="blob-num js-line-number" data-line-number="424"></td>
        <td id="LC424" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-pds">&quot;</span><span class="pl-smi">_v</span><span class="pl-k">=</span><span class="pl-smi">!%1!</span><span class="pl-s">&quot;</span></td>
      </tr>
      <tr>
        <td id="L425" class="blob-num js-line-number" data-line-number="425"></td>
        <td id="LC425" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L426" class="blob-num js-line-number" data-line-number="426"></td>
        <td id="LC426" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-k">not</span> <span class="pl-k">defined</span> _v <span class="pl-k">endlocal</span> <span class="pl-k">&amp;</span> <span class="pl-k">set</span> /a %2<span class="pl-k">=</span><span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L427" class="blob-num js-line-number" data-line-number="427"></td>
        <td id="LC427" class="blob-code blob-code-inner js-file-line"> </td>
      </tr>
      <tr>
        <td id="L428" class="blob-num js-line-number" data-line-number="428"></td>
        <td id="LC428" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">_v</span><span class="pl-k">=</span><span class="pl-smi">%_v:<span class="pl-s"> </span>=%</span></td>
      </tr>
      <tr>
        <td id="L429" class="blob-num js-line-number" data-line-number="429"></td>
        <td id="LC429" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-pds">&quot;</span><span class="pl-smi">_v</span><span class="pl-k">=</span> <span class="pl-smi">%_v%</span><span class="pl-s">&quot;</span></td>
      </tr>
      <tr>
        <td id="L430" class="blob-num js-line-number" data-line-number="430"></td>
        <td id="LC430" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> [<span class="pl-cce">^%</span>_v:~1,1<span class="pl-smi">%]==[] endlocal &amp; set /a %</span>2=<span class="pl-c1">1</span> <span class="pl-k">&amp;</span> <span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L431" class="blob-num js-line-number" data-line-number="431"></td>
        <td id="LC431" class="blob-code blob-code-inner js-file-line"> </td>
      </tr>
      <tr>
        <td id="L432" class="blob-num js-line-number" data-line-number="432"></td>
        <td id="LC432" class="blob-code blob-code-inner js-file-line"><span class="pl-k">endlocal</span> <span class="pl-k">&amp;</span> <span class="pl-k">set</span> /a %2<span class="pl-k">=</span><span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L433" class="blob-num js-line-number" data-line-number="433"></td>
        <td id="LC433" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L434" class="blob-num js-line-number" data-line-number="434"></td>
        <td id="LC434" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L435" class="blob-num js-line-number" data-line-number="435"></td>
        <td id="LC435" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">gntpoint</span></td>
      </tr>
      <tr>
        <td id="L436" class="blob-num js-line-number" data-line-number="436"></td>
        <td id="LC436" class="blob-code blob-code-inner js-file-line"><span class="pl-k">setlocal</span> disableDelayedExpansion </td>
      </tr>
      <tr>
        <td id="L437" class="blob-num js-line-number" data-line-number="437"></td>
        <td id="LC437" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L438" class="blob-num js-line-number" data-line-number="438"></td>
        <td id="LC438" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> ========================= GetNuTool =========================</span></td>
      </tr>
      <tr>
        <td id="L439" class="blob-num js-line-number" data-line-number="439"></td>
        <td id="LC439" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L440" class="blob-num js-line-number" data-line-number="440"></td>
        <td id="LC440" class="blob-code blob-code-inner js-file-line"><span class="pl-k">@</span><span class="pl-k">echo</span> off</td>
      </tr>
      <tr>
        <td id="L441" class="blob-num js-line-number" data-line-number="441"></td>
        <td id="LC441" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> GetNuTool - Executable version</span></td>
      </tr>
      <tr>
        <td id="L442" class="blob-num js-line-number" data-line-number="442"></td>
        <td id="LC442" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> Copyright (c) 2015-2017  Denis Kuzmin [ entry.reg@gmail.com ]</span></td>
      </tr>
      <tr>
        <td id="L443" class="blob-num js-line-number" data-line-number="443"></td>
        <td id="LC443" class="blob-code blob-code-inner js-file-line"><span class="pl-c"><span class="pl-c">::</span> https://github.com/3F/GetNuTool</span></td>
      </tr>
      <tr>
        <td id="L444" class="blob-num js-line-number" data-line-number="444"></td>
        <td id="LC444" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L445" class="blob-num js-line-number" data-line-number="445"></td>
        <td id="LC445" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">gntcore</span><span class="pl-k">=</span>gnt.core</td>
      </tr>
      <tr>
        <td id="L446" class="blob-num js-line-number" data-line-number="446"></td>
        <td id="LC446" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">tgnt</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%temp%</span>\<span class="pl-smi">%random%%random%%gntcore%</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L447" class="blob-num js-line-number" data-line-number="447"></td>
        <td id="LC447" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L448" class="blob-num js-line-number" data-line-number="448"></td>
        <td id="LC448" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-pds">&quot;</span><span class="pl-smi">args</span><span class="pl-k">=</span><span class="pl-v">%*</span> <span class="pl-s">&quot;</span></td>
      </tr>
      <tr>
        <td id="L449" class="blob-num js-line-number" data-line-number="449"></td>
        <td id="LC449" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">a</span><span class="pl-k">=</span><span class="pl-smi">%args:~<span class="pl-c1">0</span>,<span class="pl-c1">30</span>%</span></td>
      </tr>
      <tr>
        <td id="L450" class="blob-num js-line-number" data-line-number="450"></td>
        <td id="LC450" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">a</span><span class="pl-k">=</span><span class="pl-smi">%a:<span class="pl-s">&quot;</span>=%</span></td>
      </tr>
      <tr>
        <td id="L451" class="blob-num js-line-number" data-line-number="451"></td>
        <td id="LC451" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L452" class="blob-num js-line-number" data-line-number="452"></td>
        <td id="LC452" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%a:~<span class="pl-c1">0</span>,<span class="pl-c1">8</span>%</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-unpack <span class="pl-pds">&quot;</span></span> <span class="pl-k">goto</span> unpack</td>
      </tr>
      <tr>
        <td id="L453" class="blob-num js-line-number" data-line-number="453"></td>
        <td id="LC453" class="blob-code blob-code-inner js-file-line"><span class="pl-k">if</span> <span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-smi">%a:~<span class="pl-c1">0</span>,<span class="pl-c1">9</span>%</span><span class="pl-pds">&quot;</span></span><span class="pl-k">==</span><span class="pl-s"><span class="pl-pds">&quot;</span>-msbuild <span class="pl-pds">&quot;</span></span> <span class="pl-k">goto</span> ufound</td>
      </tr>
      <tr>
        <td id="L454" class="blob-num js-line-number" data-line-number="454"></td>
        <td id="LC454" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L455" class="blob-num js-line-number" data-line-number="455"></td>
        <td id="LC455" class="blob-code blob-code-inner js-file-line"><span class="pl-k">for</span> <span class="pl-cce">%%</span>v in (4.0, 14.0, 12.0, 3.5, 2.0) do (</td>
      </tr>
      <tr>
        <td id="L456" class="blob-num js-line-number" data-line-number="456"></td>
        <td id="LC456" class="blob-code blob-code-inner js-file-line">    <span class="pl-k">for</span> /F <span class="pl-s"><span class="pl-pds">&quot;</span>usebackq tokens=2* skip=2<span class="pl-pds">&quot;</span></span> <span class="pl-cce">%%</span>a in (</td>
      </tr>
      <tr>
        <td id="L457" class="blob-num js-line-number" data-line-number="457"></td>
        <td id="LC457" class="blob-code blob-code-inner js-file-line">        `reg <span class="pl-k">query</span> <span class="pl-s"><span class="pl-pds">&quot;</span>HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSBuild\ToolsVersions\%%v<span class="pl-pds">&quot;</span></span> /v MSBuildToolsPath 2<span class="pl-cce">^&gt;</span> <span class="pl-c1">nul</span>`</td>
      </tr>
      <tr>
        <td id="L458" class="blob-num js-line-number" data-line-number="458"></td>
        <td id="LC458" class="blob-code blob-code-inner js-file-line">    ) do <span class="pl-k">if</span> <span class="pl-k">exist</span> <span class="pl-cce">%%</span>b (</td>
      </tr>
      <tr>
        <td id="L459" class="blob-num js-line-number" data-line-number="459"></td>
        <td id="LC459" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">set</span> <span class="pl-smi">msbuildexe</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span>%%b\MSBuild.exe<span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L460" class="blob-num js-line-number" data-line-number="460"></td>
        <td id="LC460" class="blob-code blob-code-inner js-file-line">        <span class="pl-k">goto</span> found</td>
      </tr>
      <tr>
        <td id="L461" class="blob-num js-line-number" data-line-number="461"></td>
        <td id="LC461" class="blob-code blob-code-inner js-file-line">    )</td>
      </tr>
      <tr>
        <td id="L462" class="blob-num js-line-number" data-line-number="462"></td>
        <td id="LC462" class="blob-code blob-code-inner js-file-line">)</td>
      </tr>
      <tr>
        <td id="L463" class="blob-num js-line-number" data-line-number="463"></td>
        <td id="LC463" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> MSBuild was not found, try: gnt -msbuild <span class="pl-s"><span class="pl-pds">&quot;</span>fullpath<span class="pl-pds">&quot;</span></span> args <span class="pl-c1">1</span><span class="pl-k">&gt;&amp;</span>2</td>
      </tr>
      <tr>
        <td id="L464" class="blob-num js-line-number" data-line-number="464"></td>
        <td id="LC464" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">2</span></td>
      </tr>
      <tr>
        <td id="L465" class="blob-num js-line-number" data-line-number="465"></td>
        <td id="LC465" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L466" class="blob-num js-line-number" data-line-number="466"></td>
        <td id="LC466" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">ufound</span></td>
      </tr>
      <tr>
        <td id="L467" class="blob-num js-line-number" data-line-number="467"></td>
        <td id="LC467" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :popa <span class="pl-v">%1</span></td>
      </tr>
      <tr>
        <td id="L468" class="blob-num js-line-number" data-line-number="468"></td>
        <td id="LC468" class="blob-code blob-code-inner js-file-line"><span class="pl-k">shift</span></td>
      </tr>
      <tr>
        <td id="L469" class="blob-num js-line-number" data-line-number="469"></td>
        <td id="LC469" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">msbuildexe</span><span class="pl-k">=</span><span class="pl-v">%1</span></td>
      </tr>
      <tr>
        <td id="L470" class="blob-num js-line-number" data-line-number="470"></td>
        <td id="LC470" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :popa <span class="pl-v">%1</span></td>
      </tr>
      <tr>
        <td id="L471" class="blob-num js-line-number" data-line-number="471"></td>
        <td id="LC471" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L472" class="blob-num js-line-number" data-line-number="472"></td>
        <td id="LC472" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">found</span></td>
      </tr>
      <tr>
        <td id="L473" class="blob-num js-line-number" data-line-number="473"></td>
        <td id="LC473" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> :core</td>
      </tr>
      <tr>
        <td id="L474" class="blob-num js-line-number" data-line-number="474"></td>
        <td id="LC474" class="blob-code blob-code-inner js-file-line"><span class="pl-smi">%msbuildexe%</span> <span class="pl-smi">%tgnt%</span> /nologo /p:wpath=<span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-v">%~dp0</span>/<span class="pl-pds">&quot;</span></span> /v:m <span class="pl-smi">%args%</span></td>
      </tr>
      <tr>
        <td id="L475" class="blob-num js-line-number" data-line-number="475"></td>
        <td id="LC475" class="blob-code blob-code-inner js-file-line"><span class="pl-k">del</span> /Q/F <span class="pl-smi">%tgnt%</span></td>
      </tr>
      <tr>
        <td id="L476" class="blob-num js-line-number" data-line-number="476"></td>
        <td id="LC476" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L477" class="blob-num js-line-number" data-line-number="477"></td>
        <td id="LC477" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L478" class="blob-num js-line-number" data-line-number="478"></td>
        <td id="LC478" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">popa</span></td>
      </tr>
      <tr>
        <td id="L479" class="blob-num js-line-number" data-line-number="479"></td>
        <td id="LC479" class="blob-code blob-code-inner js-file-line"><span class="pl-k">call</span> <span class="pl-k">set</span> <span class="pl-smi">args</span><span class="pl-k">=</span><span class="pl-cce">%%</span>args:<span class="pl-v">%1</span> <span class="pl-cce">^=%%</span></td>
      </tr>
      <tr>
        <td id="L480" class="blob-num js-line-number" data-line-number="480"></td>
        <td id="LC480" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
      <tr>
        <td id="L481" class="blob-num js-line-number" data-line-number="481"></td>
        <td id="LC481" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L482" class="blob-num js-line-number" data-line-number="482"></td>
        <td id="LC482" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">unpack</span></td>
      </tr>
      <tr>
        <td id="L483" class="blob-num js-line-number" data-line-number="483"></td>
        <td id="LC483" class="blob-code blob-code-inner js-file-line"><span class="pl-k">set</span> <span class="pl-smi">tgnt</span><span class="pl-k">=</span><span class="pl-s"><span class="pl-pds">&quot;</span><span class="pl-v">%~dp0</span>\<span class="pl-smi">%gntcore%</span><span class="pl-pds">&quot;</span></span></td>
      </tr>
      <tr>
        <td id="L484" class="blob-num js-line-number" data-line-number="484"></td>
        <td id="LC484" class="blob-code blob-code-inner js-file-line"><span class="pl-k">echo</span> Generate minified version in <span class="pl-smi">%tgnt%</span> ...</td>
      </tr>
      <tr>
        <td id="L485" class="blob-num js-line-number" data-line-number="485"></td>
        <td id="LC485" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L486" class="blob-num js-line-number" data-line-number="486"></td>
        <td id="LC486" class="blob-code blob-code-inner js-file-line">:<span class="pl-k">core</span></td>
      </tr>
      <tr>
        <td id="L487" class="blob-num js-line-number" data-line-number="487"></td>
        <td id="LC487" class="blob-code blob-code-inner js-file-line"><span class="pl-k">&lt;</span><span class="pl-c1">nul</span> <span class="pl-k">set</span> /P =&quot;&quot;<span class="pl-k">&gt;</span><span class="pl-smi">%tgnt%</span></td>
      </tr>
      <tr>
        <td id="L488" class="blob-num js-line-number" data-line-number="488"></td>
        <td id="LC488" class="blob-code blob-code-inner js-file-line">&lt;nul set /P =^&lt;!-- GetNuTool - github.com/3F/GetNuTool --^&gt;^&lt;!-- Copyright (c) 2015-2017  Denis Kuzmin [ entry.reg@gmail.com ] --^&gt;^&lt;Project ToolsVersion=&quot;4.0&quot; xmlns=&quot;http://schemas.microsoft.com/developer/msbuild/2003&quot;^&gt;^&lt;PropertyGroup^&gt;^&lt;ngconfig Condition=&quot;&#39;$(ngconfig)&#39; == &#39;&#39;&quot;^&gt;packages.config^&lt;/ngconfig^&gt;^&lt;ngserver Condition=&quot;&#39;$(ngserver)&#39; == &#39;&#39;&quot;^&gt;https://www.nuget.org/api/v2/package/^&lt;/ngserver^&gt;^&lt;ngpackages Condition=&quot;&#39;$(ngpackages)&#39; == &#39;&#39;&quot;^&gt;^&lt;/ngpackages^&gt;^&lt;ngpath Condition=&quot;&#39;$(ngpath)&#39; == &#39;&#39;&quot;^&gt;packages^&lt;/ngpath^&gt;^&lt;/PropertyGroup^&gt;^&lt;Target Name=&quot;get&quot; BeforeTargets=&quot;Build&quot; DependsOnTargets=&quot;header&quot;^&gt;^&lt;PrepareList config=&quot;$(ngconfig)&quot; plist=&quot;$(ngpackages)&quot; wpath=&quot;$(wpath)&quot;^&gt;^&lt;Output PropertyName=&quot;plist&quot; TaskParameter=&quot;Result&quot;/^&gt;^&lt;/PrepareList^&gt;^&lt;NGDownload plist=&quot;$(plist)&quot; url=&quot;$(ngserver)&quot; wpath=&quot;$(wpath)&quot; defpath=&quot;$(ngpath)&quot; debug=&quot;$(debug)&quot;/^&gt;^&lt;/Target^&gt;^&lt;Target Name=&quot;pack&quot; DependsOnTargets=&quot;header&quot;^&gt;^&lt;NGPack dir=&quot;$(ngin)&quot; dout=&quot;$(ngout)&quot; wpath=&quot;$(wpath)&quot; vtool=&quot;$(GetNuTool)&quot; debug=&quot;$(debug)&quot;/^&gt;^&lt;/Target^&gt;^&lt;PropertyGroup^&gt;^&lt;TaskCoreDllPath Condition=&quot;Exists(&#39;$(MSBuildToolsPath)\Microsoft.Build.Tasks.v$(MSBuildToolsVersion).dll&#39;)&quot;^&gt;$(MSBuildToolsPath)\Microsoft.Build.Tasks.v$(MSBuildToolsVersion).dll^&lt;/TaskCoreDllPath^&gt;^&lt;TaskCoreDllPath Condition=&quot;&#39;$(TaskCoreDllPath)&#39; == &#39;&#39; and Exists(&#39;$(MSBuildToolsPath)\Microsoft.Build.Tasks.Core.dll&#39;)&quot;^&gt;$(MSBuildToolsPath)\Microsoft.Build.Tasks.Core.dll^&lt;/TaskCoreDllPath^&gt;^&lt;/PropertyGroup^&gt;^&lt;UsingTask TaskName=&quot;PrepareList&quot; TaskFactory=&quot;CodeTaskFactory&quot; AssemblyFile=&quot;$(TaskCoreDllPath)&quot;^&gt;^&lt;ParameterGroup^&gt;^&lt;config Parame&gt;&gt; %tgnt%</td>
      </tr>
      <tr>
        <td id="L489" class="blob-num js-line-number" data-line-number="489"></td>
        <td id="LC489" class="blob-code blob-code-inner js-file-line">&lt;nul set /P =terType=&quot;System.String&quot; Required=&quot;true&quot;/^&gt;^&lt;plist ParameterType=&quot;System.String&quot;/^&gt;^&lt;wpath ParameterType=&quot;System.String&quot;/^&gt;^&lt;Result ParameterType=&quot;System.String&quot; Output=&quot;true&quot;/^&gt;^&lt;/ParameterGroup^&gt;^&lt;Task^&gt;^&lt;Reference Include=&quot;System.Xml&quot;/^&gt;^&lt;Reference Include=&quot;System.Xml.Linq&quot;/^&gt;^&lt;Using Namespace=&quot;System&quot;/^&gt;^&lt;Using Namespace=&quot;System.Collections.Generic&quot;/^&gt;^&lt;Using Namespace=&quot;System.IO&quot;/^&gt;^&lt;Using Namespace=&quot;System.Xml.Linq&quot;/^&gt;^&lt;Code Type=&quot;Fragment&quot; Language=&quot;cs&quot;^&gt;^&lt;![CDATA[if(!String.IsNullOrEmpty(plist)){Result=plist;return true;}var _err=Console.Error;Action^&lt;string,Queue^&lt;string^&gt;^&gt; h=delegate(string cfg,Queue^&lt;string^&gt; list){foreach(var pkg in XDocument.Load(cfg).Descendants(&quot;package&quot;)){var id=pkg.Attribute(&quot;id&quot;);var version=pkg.Attribute(&quot;version&quot;);var output=pkg.Attribute(&quot;output&quot;);if(id==null){_err.WriteLine(&quot;Some &#39;id&#39; does not exist in &#39;{0}&#39;&quot;,cfg);return;}var link=id.Value;if(version!=null){link+=&quot;/&quot;+version.Value;}if(output!=null){list.Enqueue(link+&quot;:&quot;+output.Value);continue;}list.Enqueue(link);}};var ret=new Queue^&lt;string^&gt;();foreach(var cfg in config.Split(&#39;^|&#39;,&#39;;&#39;)){var lcfg=Path.Combine(wpath,cfg??&quot;&quot;);if(File.Exists(lcfg)){h(lcfg,ret);}else{_err.WriteLine(&quot;.config &#39;{0}&#39; was not found.&quot;,lcfg);}}if(ret.Count ^&lt; 1){_err.WriteLine(&quot;List of packages is empty. Use .config or /p:ngpackages=\&quot;...\&quot;\n&quot;);}else{Result=String.Join(&quot;;&quot;,ret.ToArray());}]]^&gt;^&lt;/Code^&gt;^&lt;/Task^&gt;^&lt;/UsingTask^&gt;^&lt;UsingTask TaskName=&quot;NGDownload&quot; TaskFactory=&quot;CodeTaskFactory&quot; AssemblyFile=&quot;$(TaskCoreDllPath)&quot;^&gt;^&lt;ParameterGroup^&gt;^&lt;plist ParameterType=&quot;System.String&quot;/^&gt;^&lt;url Paramet&gt;&gt; %tgnt%</td>
      </tr>
      <tr>
        <td id="L490" class="blob-num js-line-number" data-line-number="490"></td>
        <td id="LC490" class="blob-code blob-code-inner js-file-line">&lt;nul set /P =erType=&quot;System.String&quot; Required=&quot;true&quot;/^&gt;^&lt;wpath ParameterType=&quot;System.String&quot;/^&gt;^&lt;defpath ParameterType=&quot;System.String&quot;/^&gt;^&lt;debug ParameterType=&quot;System.Boolean&quot;/^&gt;^&lt;/ParameterGroup^&gt;^&lt;Task^&gt;^&lt;Reference Include=&quot;WindowsBase&quot;/^&gt;^&lt;Using Namespace=&quot;System&quot;/^&gt;^&lt;Using Namespace=&quot;System.IO&quot;/^&gt;^&lt;Using Namespace=&quot;System.IO.Packaging&quot;/^&gt;^&lt;Using Namespace=&quot;System.Net&quot;/^&gt;^&lt;Code Type=&quot;Fragment&quot; Language=&quot;cs&quot;^&gt;^&lt;![CDATA[if(plist==null){return false;}var ignore=new string[]{&quot;/_rels/&quot;,&quot;/package/&quot;,&quot;/[Content_Types].xml&quot;};Action^&lt;string,object^&gt; dbg=delegate(string s,object p){if(debug){Console.WriteLine(s,p);}};Func^&lt;string,string^&gt; loc=delegate(string p){return Path.Combine(wpath,p??&quot;&quot;);};Action^&lt;string,string,string^&gt; get=delegate(string link,string name,string path){var to=Path.GetFullPath(loc(path??name));if(Directory.Exists(to)){Console.WriteLine(&quot;`{0}` is already exists: \&quot;{1}\&quot;&quot;,name,to);return;}Console.Write(&quot;Getting `{0}` ... &quot;,link);var tmp=Path.Combine(Path.GetTempPath(),Guid.NewGuid().ToString());using(var l=new WebClient()){try{l.Headers.Add(&quot;User-Agent&quot;,&quot;GetNuTool&quot;);l.UseDefaultCredentials=true;l.DownloadFile(url+link,tmp);}catch(Exception ex){Console.Error.WriteLine(ex.Message);return;}}Console.WriteLine(&quot;Extracting into \&quot;{0}\&quot;&quot;,to);using(var pkg=ZipPackage.Open(tmp,FileMode.Open,FileAccess.Read)){foreach(var part in pkg.GetParts()){var uri=Uri.UnescapeDataString(part.Uri.OriginalString);if(ignore.Any(x=^&gt; uri.StartsWith(x,StringComparison.Ordinal))){continue;}var dest=Path.Combine(to,uri.TrimStart(&#39;/&#39;));dbg(&quot;- `{0}`&quot;,uri);var dir=Path.GetDirectoryNam&gt;&gt; %tgnt%</td>
      </tr>
      <tr>
        <td id="L491" class="blob-num js-line-number" data-line-number="491"></td>
        <td id="LC491" class="blob-code blob-code-inner js-file-line">&lt;nul set /P =e(dest);if(!Directory.Exists(dir)){Directory.CreateDirectory(dir);}using(var src=part.GetStream(FileMode.Open,FileAccess.Read))using(var target=File.OpenWrite(dest)){try{src.CopyTo(target);}catch(FileFormatException ex){dbg(&quot;[x]?crc: {0}&quot;,dest);}}}}File.Delete(tmp);};foreach(var pkg in plist.Split(&#39;;&#39;)){var ident=pkg.Split(&#39;:&#39;);var link=ident[0];var path=(ident.Length ^&gt; 1)?ident[1]: null;var name=link.Replace(&#39;/&#39;,&#39;.&#39;);if(!String.IsNullOrEmpty(defpath)){path=Path.Combine(defpath,path??name);}get(link,name,path);}]]^&gt;^&lt;/Code^&gt;^&lt;/Task^&gt;^&lt;/UsingTask^&gt;^&lt;UsingTask TaskName=&quot;NGPack&quot; TaskFactory=&quot;CodeTaskFactory&quot; AssemblyFile=&quot;$(TaskCoreDllPath)&quot;^&gt;^&lt;ParameterGroup^&gt;^&lt;dir ParameterType=&quot;System.String&quot; Required=&quot;true&quot;/^&gt;^&lt;dout ParameterType=&quot;System.String&quot;/^&gt;^&lt;wpath ParameterType=&quot;System.String&quot;/^&gt;^&lt;vtool ParameterType=&quot;System.String&quot; Required=&quot;true&quot;/^&gt;^&lt;debug ParameterType=&quot;System.Boolean&quot;/^&gt;^&lt;/ParameterGroup^&gt;^&lt;Task^&gt;^&lt;Reference Include=&quot;System.Xml&quot;/^&gt;^&lt;Reference Include=&quot;System.Xml.Linq&quot;/^&gt;^&lt;Reference Include=&quot;WindowsBase&quot;/^&gt;^&lt;Using Namespace=&quot;System&quot;/^&gt;^&lt;Using Namespace=&quot;System.Collections.Generic&quot;/^&gt;^&lt;Using Namespace=&quot;System.IO&quot;/^&gt;^&lt;Using Namespace=&quot;System.Linq&quot;/^&gt;^&lt;Using Namespace=&quot;System.IO.Packaging&quot;/^&gt;^&lt;Using Namespace=&quot;System.Xml.Linq&quot;/^&gt;^&lt;Using Namespace=&quot;System.Text.RegularExpressions&quot;/^&gt;^&lt;Code Type=&quot;Fragment&quot; Language=&quot;cs&quot;^&gt;^&lt;![CDATA[var EXT_NUSPEC=&quot;.nuspec&quot;;var EXT_NUPKG=&quot;.nupkg&quot;;var TAG_META=&quot;metadata&quot;;var DEF_CONTENT_TYPE=&quot;application/octet&quot;;var MANIFEST_URL=&quot;http://schemas.microsoft.com/packaging/2010/07/manifest&quot;;var ID=&quot;id&quot;;var VER=&quot;version&quot;&gt;&gt; %tgnt%</td>
      </tr>
      <tr>
        <td id="L492" class="blob-num js-line-number" data-line-number="492"></td>
        <td id="LC492" class="blob-code blob-code-inner js-file-line">&lt;nul set /P =;Action^&lt;string,object^&gt; dbg=delegate(string s,object p){if(debug){Console.WriteLine(s,p);}};var _err=Console.Error;dir=Path.Combine(wpath,dir);if(!Directory.Exists(dir)){_err.WriteLine(&quot;`{0}` was not found.&quot;,dir);return false;}dout=Path.Combine(wpath,dout??&quot;&quot;);var nuspec=Directory.GetFiles(dir,&quot;*&quot;+EXT_NUSPEC,SearchOption.TopDirectoryOnly).FirstOrDefault();if(nuspec==null){_err.WriteLine(&quot;{0} was not found in `{1}`&quot;,EXT_NUSPEC,dir);return false;}Console.WriteLine(&quot;Found {0}: `{1}`&quot;,EXT_NUSPEC,nuspec);var root=XDocument.Load(nuspec).Root.Elements().FirstOrDefault(x=^&gt; x.Name.LocalName==TAG_META);if(root==null){_err.WriteLine(&quot;{0} does not contain {1}.&quot;,nuspec,TAG_META);return false;}var metadata=new Dictionary^&lt;string,string^&gt;();foreach(var tag in root.Elements()){metadata[tag.Name.LocalName.ToLower()]=tag.Value;}if(metadata[ID].Length ^&gt; 100 ^|^|!Regex.IsMatch(metadata[ID],@&quot;^\w+([_.-]\w+)*$&quot;,RegexOptions.IgnoreCase ^| RegexOptions.ExplicitCapture)){_err.WriteLine(&quot;The format of `{0}` is not correct.&quot;,ID);return false;}var ignore=new string[]{Path.Combine(dir,&quot;_rels&quot;),Path.Combine(dir,&quot;package&quot;),Path.Combine(dir,&quot;[Content_Types].xml&quot;)};var pout=String.Format(&quot;{0}.{1}{2}&quot;,metadata[ID],metadata[VER],EXT_NUPKG);if(!String.IsNullOrWhiteSpace(dout)){if(!Directory.Exists(dout)){Directory.CreateDirectory(dout);}pout=Path.Combine(dout,pout);}Console.WriteLine(&quot;Started packing `{0}` ...&quot;,pout);using(var pkg=Package.Open(pout,FileMode.Create)){var manifestUri=new Uri(String.Format(&quot;/{0}{1}&quot;,metadata[ID],EXT_NUSPEC),UriKind.Relative);pkg.CreateRelationship(manif&gt;&gt; %tgnt%</td>
      </tr>
      <tr>
        <td id="L493" class="blob-num js-line-number" data-line-number="493"></td>
        <td id="LC493" class="blob-code blob-code-inner js-file-line">&lt;nul set /P =estUri,TargetMode.Internal,MANIFEST_URL);foreach(var file in Directory.GetFiles(dir,&quot;*.*&quot;,SearchOption.AllDirectories)){if(ignore.Any(x=^&gt; file.StartsWith(x,StringComparison.Ordinal))){continue;}string pUri;if(file.StartsWith(dir,StringComparison.OrdinalIgnoreCase)){pUri=file.Substring(dir.Length).TrimStart(Path.DirectorySeparatorChar);}else{pUri=file;}dbg(&quot;- `{0}`&quot;,pUri);var escaped=String.Join(&quot;/&quot;,pUri.Split(&#39;\\&#39;,&#39;/&#39;).Select(p=^&gt; Uri.EscapeDataString(p)));var uri=PackUriHelper.CreatePartUri(new Uri(escaped,UriKind.Relative));var part=pkg.CreatePart(uri,DEF_CONTENT_TYPE,CompressionOption.Maximum);using(var tstream=part.GetStream())using(var fs=new FileStream(file,FileMode.Open,FileAccess.Read)){fs.CopyTo(tstream);}}Func^&lt;string,string^&gt; getmeta=delegate(string key){return(metadata.ContainsKey(key))?metadata[key]:&quot;&quot;;};var _p=pkg.PackageProperties;_p.Creator=getmeta(&quot;authors&quot;);_p.Description=getmeta(&quot;description&quot;);_p.Identifier=metadata[ID];_p.Version=metadata[VER];_p.Keywords=getmeta(&quot;tags&quot;);_p.Title=getmeta(&quot;title&quot;);_p.LastModifiedBy=&quot;GetNuTool v&quot;+vtool;}]]^&gt;^&lt;/Code^&gt;^&lt;/Task^&gt;^&lt;/UsingTask^&gt;^&lt;Target Name=&quot;Build&quot; DependsOnTargets=&quot;get&quot;/^&gt;^&lt;PropertyGroup^&gt;^&lt;GetNuTool^&gt;1.6.1.10620_bde3e50^&lt;/GetNuTool^&gt;^&lt;wpath Condition=&quot;&#39;$(wpath)&#39; == &#39;&#39;&quot;^&gt;$(MSBuildProjectDirectory)^&lt;/wpath^&gt;^&lt;/PropertyGroup^&gt;^&lt;Target Name=&quot;header&quot;^&gt;^&lt;Message Text=&quot;%%0D%%0AGetNuTool v$(GetNuTool) - github.com/3F%%0D%%0A=========%%0D%%0A&quot; Importance=&quot;high&quot;/^&gt;^&lt;/Target^&gt;^&lt;/Project^&gt;&gt;&gt; %tgnt%</td>
      </tr>
      <tr>
        <td id="L494" class="blob-num js-line-number" data-line-number="494"></td>
        <td id="LC494" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L495" class="blob-num js-line-number" data-line-number="495"></td>
        <td id="LC495" class="blob-code blob-code-inner js-file-line">
</td>
      </tr>
      <tr>
        <td id="L496" class="blob-num js-line-number" data-line-number="496"></td>
        <td id="LC496" class="blob-code blob-code-inner js-file-line"><span class="pl-k">exit</span> /B <span class="pl-c1">0</span></td>
      </tr>
</table>

  <div class="BlobToolbar position-absolute js-file-line-actions dropdown js-menu-container js-select-menu d-none" aria-hidden="true">
    <button class="btn-octicon ml-0 px-2 p-0 bg-white border border-gray-dark rounded-1 dropdown-toggle js-menu-target" id="js-file-line-action-button" type="button" aria-expanded="false" aria-haspopup="true" aria-label="Inline file action toolbar" aria-controls="inline-file-actions">
      <svg aria-hidden="true" class="octicon" height="16" version="1.1" viewBox="0 0 13 4" width="14">
        <g stroke="none" stroke-width="1" fill-rule="evenodd">
            <g transform="translate(-1.000000, -6.000000)">
                <path d="M2.5,9.5 C1.67157288,9.5 1,8.82842712 1,8 C1,7.17157288 1.67157288,6.5 2.5,6.5 C3.32842712,6.5 4,7.17157288 4,8 C4,8.82842712 3.32842712,9.5 2.5,9.5 Z M7.5,9.5 C6.67157288,9.5 6,8.82842712 6,8 C6,7.17157288 6.67157288,6.5 7.5,6.5 C8.32842712,6.5 9,7.17157288 9,8 C9,8.82842712 8.32842712,9.5 7.5,9.5 Z M12.5,9.5 C11.6715729,9.5 11,8.82842712 11,8 C11,7.17157288 11.6715729,6.5 12.5,6.5 C13.3284271,6.5 14,7.17157288 14,8 C14,8.82842712 13.3284271,9.5 12.5,9.5 Z"></path>
            </g>
        </g>
      </svg>
    </button>
    <div class="dropdown-menu-content js-menu-content" id="inline-file-actions">
      <ul class="BlobToolbar-dropdown dropdown-menu dropdown-menu-se mt-2">
        <li><a class="js-zeroclipboard dropdown-item" style="cursor:pointer;" id="js-copy-lines" data-original-text="Copy lines">Copy lines</a></li>
        <li><a class="js-zeroclipboard dropdown-item" id= "js-copy-permalink" style="cursor:pointer;" data-original-text="Copy permalink">Copy permalink</a></li>
        <li><a href="/PentiaLabs/helix-powershell-poc/blame/ef19eb559b74deb66fe7775dad866dd2b134b96c/Get-MSBuild/lib/hMSBuild.bat" class="dropdown-item js-update-url-with-hash" id="js-view-git-blame">View git blame</a></li>
          <li><a href="/PentiaLabs/helix-powershell-poc/issues/new" class="dropdown-item" id="js-new-issue">Open new issue</a></li>
      </ul>
    </div>
  </div>

  </div>

  </div>

  <button type="button" data-facebox="#jump-to-line" data-facebox-class="linejump" data-hotkey="l" class="d-none">Jump to Line</button>
  <div id="jump-to-line" style="display:none">
    <!-- '"` --><!-- </textarea></xmp> --></option></form><form accept-charset="UTF-8" action="" class="js-jump-to-line-form" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
      <input class="form-control linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" aria-label="Jump to line" autofocus>
      <button type="submit" class="btn">Go</button>
</form>  </div>

  </div>
  <div class="modal-backdrop js-touch-events"></div>
</div>

    </div>
  </div>

  </div>

      
<div class="footer container-lg px-3" role="contentinfo">
  <div class="position-relative d-flex flex-justify-between py-6 mt-6 f6 text-gray border-top border-gray-light ">
    <ul class="list-style-none d-flex flex-wrap ">
      <li class="mr-3">&copy; 2017 <span title="0.18013s from unicorn-1122250090-r5hlj">GitHub</span>, Inc.</li>
        <li class="mr-3"><a href="https://github.com/site/terms" data-ga-click="Footer, go to terms, text:terms">Terms</a></li>
        <li class="mr-3"><a href="https://github.com/site/privacy" data-ga-click="Footer, go to privacy, text:privacy">Privacy</a></li>
        <li class="mr-3"><a href="https://github.com/security" data-ga-click="Footer, go to security, text:security">Security</a></li>
        <li class="mr-3"><a href="https://status.github.com/" data-ga-click="Footer, go to status, text:status">Status</a></li>
        <li><a href="https://help.github.com" data-ga-click="Footer, go to help, text:help">Help</a></li>
    </ul>

    <a href="https://github.com" aria-label="Homepage" class="footer-octicon" title="GitHub">
      <svg aria-hidden="true" class="octicon octicon-mark-github" height="24" version="1.1" viewBox="0 0 16 16" width="24"><path fill-rule="evenodd" d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59.4.07.55-.17.55-.38 0-.19-.01-.82-.01-1.49-2.01.37-2.53-.49-2.69-.94-.09-.23-.48-.94-.82-1.13-.28-.15-.68-.52-.01-.53.63-.01 1.08.58 1.23.82.72 1.21 1.87.87 2.33.66.07-.52.28-.87.51-1.07-1.78-.2-3.64-.89-3.64-3.95 0-.87.31-1.59.82-2.15-.08-.2-.36-1.02.08-2.12 0 0 .67-.21 2.2.82.64-.18 1.32-.27 2-.27.68 0 1.36.09 2 .27 1.53-1.04 2.2-.82 2.2-.82.44 1.1.16 1.92.08 2.12.51.56.82 1.27.82 2.15 0 3.07-1.87 3.75-3.65 3.95.29.25.54.73.54 1.48 0 1.07-.01 1.93-.01 2.2 0 .21.15.46.55.38A8.013 8.013 0 0 0 16 8c0-4.42-3.58-8-8-8z"/></svg>
</a>
    <ul class="list-style-none d-flex flex-wrap ">
        <li class="mr-3"><a href="https://github.com/contact" data-ga-click="Footer, go to contact, text:contact">Contact GitHub</a></li>
      <li class="mr-3"><a href="https://developer.github.com" data-ga-click="Footer, go to api, text:api">API</a></li>
      <li class="mr-3"><a href="https://training.github.com" data-ga-click="Footer, go to training, text:training">Training</a></li>
      <li class="mr-3"><a href="https://shop.github.com" data-ga-click="Footer, go to shop, text:shop">Shop</a></li>
        <li class="mr-3"><a href="https://github.com/blog" data-ga-click="Footer, go to blog, text:blog">Blog</a></li>
        <li><a href="https://github.com/about" data-ga-click="Footer, go to about, text:about">About</a></li>

    </ul>
  </div>
</div>



  <div id="ajax-error-message" class="ajax-error-message flash flash-error">
    <svg aria-hidden="true" class="octicon octicon-alert" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.865 1.52c-.18-.31-.51-.5-.87-.5s-.69.19-.87.5L.275 13.5c-.18.31-.18.69 0 1 .19.31.52.5.87.5h13.7c.36 0 .69-.19.86-.5.17-.31.18-.69.01-1L8.865 1.52zM8.995 13h-2v-2h2v2zm0-3h-2V6h2v4z"/></svg>
    <button type="button" class="flash-close js-flash-close js-ajax-error-dismiss" aria-label="Dismiss error">
      <svg aria-hidden="true" class="octicon octicon-x" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
    </button>
    You can't perform that action at this time.
  </div>


    
    <script crossorigin="anonymous" integrity="sha256-8q4ohCjL4ztV3ECDYeIe1e5DMasRlfxtng0fybFEsEI=" src="https://assets-cdn.github.com/assets/frameworks-f2ae288428cbe33b55dc408361e21ed5ee4331ab1195fc6d9e0d1fc9b144b042.js"></script>
    
    <script async="async" crossorigin="anonymous" integrity="sha256-ChWOvoe+k67GIEW+C/Kc22Up1vC94KODd148pocOLrE=" src="https://assets-cdn.github.com/assets/github-0a158ebe87be93aec62045be0bf29cdb6529d6f0bde0a383775e3ca6870e2eb1.js"></script>
    
    
    
    
  <div class="js-stale-session-flash stale-session-flash flash flash-warn flash-banner d-none">
    <svg aria-hidden="true" class="octicon octicon-alert" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path fill-rule="evenodd" d="M8.865 1.52c-.18-.31-.51-.5-.87-.5s-.69.19-.87.5L.275 13.5c-.18.31-.18.69 0 1 .19.31.52.5.87.5h13.7c.36 0 .69-.19.86-.5.17-.31.18-.69.01-1L8.865 1.52zM8.995 13h-2v-2h2v2zm0-3h-2V6h2v4z"/></svg>
    <span class="signed-in-tab-flash">You signed in with another tab or window. <a href="">Reload</a> to refresh your session.</span>
    <span class="signed-out-tab-flash">You signed out in another tab or window. <a href="">Reload</a> to refresh your session.</span>
  </div>
  <div class="facebox" id="facebox" style="display:none;">
  <div class="facebox-popup">
    <div class="facebox-content" role="dialog" aria-labelledby="facebox-header" aria-describedby="facebox-description">
    </div>
    <button type="button" class="facebox-close js-facebox-close" aria-label="Close modal">
      <svg aria-hidden="true" class="octicon octicon-x" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path fill-rule="evenodd" d="M7.48 8l3.75 3.75-1.48 1.48L6 9.48l-3.75 3.75-1.48-1.48L4.52 8 .77 4.25l1.48-1.48L6 6.52l3.75-3.75 1.48 1.48z"/></svg>
    </button>
  </div>
</div>


  </body>
</html>

