---
layout: post
title: "How to integrate DaisyUI - Nexus Dashboard to Phoenix Web Framework 1.8"
date: 2025-05-04 17:45:17
update:
location: Saigon
tags:
categories:
- Elixir
seo_description: A guide to integrate Nexus Dashboard to Phoenix Web Framework 1.8
seo_image: /image/posts/2025-05-04-How-to-integrate-DaisyUI-Nexus-Dashboard-to-Phoenix-Web-Framework-1.8/seo.png
comments: true
---

This post will guide you integrate [Nexus Dashboard](https://daisyui.com/store/244268/) to Phoenix Web Framework. First of all, you should buy and use [Nexus Dashboard](https://daisyui.com/store/244268/) instead of craking it!

I will assume that you did download and unzip the web dashboard template, The latest version is `2.2.0`.

# Step 1: Go to nexus directory, find css assets.
My nexus version is `2.2.0`, after unzip, you will need to go to `nexus-html@2.2.0/src/styles/`.

All css assets here! The whole point now is to replace `phoenix app.css` to `nexus app.css`.

The `nexus app.css` look like this:

{% highlight css %}
/* Root Styling */
@import "./typography.css";
@import "./tailwind.css";
@import "./daisyui.css";

/* Custom Styling */
@import "./custom/animation.css";
@import "./custom/components.css";
@import "./custom/layout.css";

/* Plugin Overriding */
@import "./custom/plugins.css";

/* Pages */
@import "./custom/landing.css";

/* Plugin: Iconify (Lucide icons) */
@plugin "@iconify/tailwind4" {
    prefixes: lucide;
}

{% endhighlight %}

As you can see, they use import another css in relative paths. When we integrate it with phoenix, we need to take care those paths.


# Step 2: Copy nexus css assets to phoenix web app
In phoenix web app, open directory `/assets/css/` and create a new sub-directory named `nexus_dashboard`.
In this `assets/css/nexus_dashboard`, copy nexus css into this, except `app.css`.

This is a directory tree after copy.
```text
$ tree assets/css/nexus_dashboard

assets/css/nexus_dashboard
├── custom
│   ├── animation.css
│   ├── components.css
│   ├── landing.css
│   ├── layout.css
│   └── plugins.css
├── daisyui.css
├── tailwind.css
└── typography.css

```

# Step 3: Create `nexus_app.css` from `nexus app.css`
Now, come back the `app.css`, I dotn want a conflict with the existing one `app.css`, so I named a new main css file as `nexus_app.css`. In addition, due to different relative paths, I must update these with `./nexus_dashboard`.

{% highlight css %}
/* Root Styling */
@import "./nexus_dashboard/typography.css";
@import "./nexus_dashboard/tailwind.css";
@import "./nexus_dashboard/daisyui.css";

/* Custom Styling */
@import "./nexus_dashboard/custom/animation.css";
@import "./nexus_dashboard/custom/components.css";
@import "./nexus_dashboard/custom/layout.css";

/* Plugin Overriding */
@import "./nexus_dashboard/custom/plugins.css";

/* Pages */
@import "./nexus_dashboard/custom/landing.css";

/* Plugin: Iconify (Lucide icons) */
@plugin "../node_modules/@iconify/tailwind4" {
    prefixes: lucide;
}

{% endhighlight %}

# Step 4. Modify phoenix web app, `config/config.exs`
Go to `config/config.exs`, find config for  `:tailwind` and modify it to use `nexus_app.css`. For example:

{% highlight elixir %}
config :tailwind,
  version: "4.1.4",
  mining_rig_monitor: [
    args: ~w(
      --input=css/nexus_app.css
      --output=../priv/static/assets/nexus_app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]
{% endhighlight %}

# Step 5. Build and debug
You gonna see a lot of missing javascrip library from now on, but I will show you how to solve it. At first, run `mix tailwind _project_name`.


100% you gonna see missing `daisyui.js` and `daisyui-theme.js` in `assets/css/nexus_dashboard/daisyui.css`. To solve it, you need to use relative path to `assets/vendor/daisyui.js` and `assets/vendor/daisyui-theme.js`. I would like to keep these file as is. When you create phoenix 1.8 project, `daisyui.js` and `daisyui-theme.js` is already there!.

if you delete these files and want it back, you can find it here: [Use daisyUI with Tailwind CSS Standalone CLI](https://daisyui.com/docs/install/standalone/#2-get-daisyui-bundled-js-file)

For example, this is my `assets/css/nexus_dashboard/daisyui.css`.

**There are more relative paths need to be updated. Take care!**

{% highlight css %}
@plugin "../../vendor/daisyui.js" {
    exclude: rootscrollgutter;
}

@plugin "../../vendor/daisyui-theme.js" {
    name: "dark";
    color-scheme: dark;
    prefersdark: true;
{% endhighlight %}

In addition, you gonna see a mission `iconify/tailwind4` library. At this point, there is no choice but using `npm ecosystem`. In `assets`, run npm install `@iconify-json/lucide` and `@iconify/tailwind4`.

This is content for `assets/package.json`. I really want to depend as less as possible the `npm ecosystem`, but have no choice.

{% highlight json %}
{
  "dependencies": {
    "@iconify-json/lucide": "^1.2.39",
    "@iconify/tailwind4": "^1.0.6"
  }
}

{% endhighlight %}

At this point, you should be able to run `mix tailwind phoenix_app_name` to build your `nexus_app.css`.


{% highlight shell %}
$ mix tailwind mining_rig_monitor
/*! 🌼 daisyUI 5.0.28 */
≈ tailwindcss v4.1.4

Done in 286ms
{% endhighlight %}

---
A minor note for you, cause you need `lucide-icon` and rely on `npm install` to collect `@iconify, lucide and tailwind4` for `lucide-icon`. it's a good idea that you can ignore prebuild `vendor/daisyui.js and daisyui-theme.js`,
just use `npm install` these two library. Remember to update your `nexus_dashboard/daisyui.css`'s relative paths.
