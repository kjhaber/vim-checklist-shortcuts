# vim-checklist-shortcuts
Vim plugin containing shortcuts for working with checklists

I already use [vimwiki](https://github.com/vimwiki/vimwiki) so perhaps ironically this plugin doesn't include toggling "[ ]" and "[x]" as checklist items (though maybe there's a case for doing that).

Instead I use these shortcuts for managing large checklists, like my grocery list.  Why is my grocery list large?  Because I have a `Grocery.md` file that contains most items I've bought from the grocery over the last five or more years, and I don't often remove items - it helps me remember them later.

The way I use it is:
* I open `Grocery.md`, find items I need and uncheck them (adding them if they're actually new).
  - The items are grouped with Markdown headings ("## BAKERY", "## FROZEN", etc.).
* I use `:ChecklistShortCopy` to create `GroceryShort.md` ("${BASENAME}Short.md").
  - I have this mapped to `<leader>cc`, quick to hit to "refresh" changes to the short checklist
  - `GroceryShort.md` contains only the unchecked items from `Grocery.md`
  - Items are grouped under the same Markdown headings as in `Grocery.md`.
* I use `:ChecklistShortOpen` to open `GroceryShort.md` in a new vertical split so I can quickly see the abridged checklist.
  - I have this mapped to `<leader>c>`, I think of opening the window to the >>right>>.
* On my phone at the store I check items off in `GroceryShort.md`.
  - I'm an Android user, and [Markor](https://github.com/gsantner/markor) is my Markdown editor of choice for my phone. Highly recommended!
* After I've returned from shopping, I want to quickly find the unchecked items to check them back off again.  To do that I use `:ChecklistJumpToNextUncheckedbox` and `:ChecklistJumpToPrevUncheckedbox`
  - I have "next open" mapped to `<leader>co`
  - I have "prev open" mapped to `<leader>cO` (shift-O for reverse direction)
  - I have "next X'd out" mapped to `<leader>cx`
  - I have "prev X'd out" mapped to `<leader>cX` (shift-X for reverse direction)
  - Maybe I should make a shortcut that checks the items back off from GroceryShort.md to handle that in one command.  But it's still faster than scrolling through the whole file.

## Installation

The usual vim plugin install methods should work (vim-plug, lazy.nvim, Pathogen or equivalent):

vim-plug version:
```
Plug 'kjhaber/vim-checklist-shortcuts'
```

To disable default leader mappings, add `let g:vim_checklist_shortcuts_map_keys = 0` to your vimrc before the plugin loads.


## License
MIT

