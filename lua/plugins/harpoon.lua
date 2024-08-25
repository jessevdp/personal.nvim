return {
 "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon.setup()

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():add()
    end, { desc = "[H]arpoon [A]dd Mark" })

    vim.keymap.set("n", "<leader>hd", function()
      harpoon:list():remove()
    end, { desc = "[H]arpoon [D]elete Mark" })

    vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "[H]arpoon Mark [1]" })
    vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "[H]arpoon Mark [2]" })
    vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "[H]arpoon Mark [3]" })
    vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "[H]arpoon Mark [4]" })
    vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end, { desc = "[H]arpoon Mark [5]" })
    vim.keymap.set("n", "<leader>h6", function() harpoon:list():select(6) end, { desc = "[H]arpoon Mark [6]" })
    vim.keymap.set("n", "<leader>h7", function() harpoon:list():select(7) end, { desc = "[H]arpoon Mark [7]" })
    vim.keymap.set("n", "<leader>h8", function() harpoon:list():select(8) end, { desc = "[H]arpoon Mark [8]" })
    vim.keymap.set("n", "<leader>h9", function() harpoon:list():select(9) end, { desc = "[H]arpoon Mark [9]" })

    -- vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "[H]arpoon [P]revious Mark" })
    vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "[H]arpoon [N]ext Mark" })

    -- =========================================================================
    -- telescope integration
    -- =========================================================================

    local action_state = require("telescope.actions.state")
    local action_utils = require("telescope.actions.utils")
    local entry_display = require("telescope.pickers.entry_display")
    local finders = require("telescope.finders")
    local pickers = require("telescope.pickers")
    local themes = require("telescope.themes")
    local conf = require("telescope.config").values

    local generate_new_finder = function()
      local harpoon_list = harpoon:list()
      local items = {}
      for i, item in ipairs(harpoon_list.items) do
        table.insert(items, { harpoon_index = i, item = item})
      end

      return finders.new_table({
        results = items,
        entry_maker = function(entry)
          return {
            value = entry.item,
            ordinal = entry.item.value,
            display = tostring(entry.harpoon_index) .. ": " .. entry.item.value,
            filename = entry.item.value,
          }
        end,
      })
    end

    local delete_harpoon_mark = function(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      local index = selection.index

      -- yes... this really sucks.. but for some reason calling "remove" messes
      -- up the list with an empty in the middle. Clearing the list and rebuilding
      -- seems to work...
      local items = harpoon:list().items
      harpoon:list():clear()
      for i, item in ipairs(items) do
        if item ~= selection.value then
          harpoon:list():add(item)
        end
      end

      local current_picker = action_state.get_current_picker(prompt_bufnr)
      current_picker:refresh(generate_new_finder(), { reset_prompt = false })

      -- TODO: keep current selection
    end

    local move_mark_down = function(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      local length = harpoon:list():length()
      if selection.index == length then
        return
      end
      local mark_list = harpoon:list().items
      table.remove(mark_list, selection.index)
      table.insert(mark_list, selection.index + 1, selection.value)
      local current_picker = action_state.get_current_picker(prompt_bufnr)
      current_picker:refresh(generate_new_finder(), { reset_prompt = true })
      -- yes defer_fn is an awful solution. If you find a better one, please let the world know.
      -- it's used here because we need to wait for the picker to refresh before we can set the selection
      -- actions.move_selection_next() doesn't work here because the selection gets reset to 0 on every refresh.
      vim.defer_fn(function()
        current_picker:set_selection(selection.index)
      end, 2) -- 2ms was the minimum delay I could find that worked without glitching out the picker
    end

    local move_mark_up = function(prompt_bufnr)
      local selection = action_state.get_selected_entry()
      if selection.index == 1 then
        return
      end
      local mark_list = harpoon:list().items
      table.remove(mark_list, selection.index)
      table.insert(mark_list, selection.index - 1, selection.value)
      local current_picker = action_state.get_current_picker(prompt_bufnr)
      current_picker:refresh(generate_new_finder(), { reset_prompt = true })
      -- yes defer_fn is an awful solution. If you find a better one, please let the world know.
      -- it's used here because we need to wait for the picker to refresh before we can set the selection
      -- actions.move_selection_previous() doesn't work here because the selection gets reset to 0 on every refresh.
      vim.defer_fn(function()
        -- don't even bother finding out why this is -2 here. (i don't know either)
        current_picker:set_selection(selection.index - 2)
      end, 2) -- 2ms was the minimum delay I could find that worked without glitching out the picker
    end

    local function launch_telescope_harpoon_marks()
      pickers.new(
        themes.get_dropdown({
          previewer = false, -- TODO: make previewer work.
        }),
        {
          prompt_title = "Harpoon marks",
          initial_mode = "normal",
          finder = generate_new_finder(),
          previewer = conf.file_previewer({}),
          sorter = conf.generic_sorter({}),
          default_selection_index = 1,
          attach_mappings = function(_, map)
            map({ "n", "i" }, "<C-d>", delete_harpoon_mark)
            map({ "n", "i" }, "<C-k>", move_mark_up)
            map({ "n", "i" }, "<C-j>", move_mark_down)
            return true
          end,
        }
      ):find()
    end

    vim.keymap.set("n", "<leader>hs", function()
      launch_telescope_harpoon_marks()
    end, { desc = "[H]arpoon [S]how Marks" })
  end
}
