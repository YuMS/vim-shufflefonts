# vim-shufflefonts

This is a productivity VIM plugin which will pick a random font from your carefully picked 'font playlist' automatically when you read a new file or switch the window. And of course, you can manually switch to the next font whenever you want.

I call it productivity plugin because codes are usually updated so slow that they almost look the same. Fast changing fonts will make your codes not that rotten to touch.

So get this and your ‘font playlist’ and make your one day two.

## Dependency

Since [vim-fontsize](https://github.com/drmikehenry/vim-fontsize) has already done some great infrastructural font related processing works, I decided to get benefits from it.

So, You need to also add his plugin to make this one work.

## Installation

It is [Vundle](https://github.com/gmarik/Vundle.vim) which showed a noob like me a way to separate my own plugins from everything-mixed-together `.vimrc` file. So I’ll only tell you how to do it with Vundle:

Append

```
    Bundle 'drmikehenry/vim-fontsize'
    Bundle 'YuMS/vim-shufflefonts'
```
in your `.vimrc`.

Execute
```
    $vim +BundleInstall
```
and it should work.


## Customization

 * A font playlist is required. Illustrated below:
```
    let g:shufflefonts_fonts_list = [
        \'Inconsolata',
        \'Consolas',
    \]
```
 * Auto changing can be disabled by:
```
    let g:shufflefonts_on_switch = 0
```

## Fonts

I found it beautiful for fonts on [google fonts](http://www.google.com/fonts/)

## Know Issues

As font name will be shown at statusline on switches, 'shufflefonts' may conflict with some plugins doing similar things. Like `bling/vim-bufferline`.

You can disable echoing of `vim-bufferline` by appending `let g:bufferline_echo = 0` in your `.vimrc` if you want to know which font is it on showing up.
