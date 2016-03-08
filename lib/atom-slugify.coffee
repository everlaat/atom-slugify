#
# * atom-slugify
# * https://github.com/everlaat/atom-slugify
# *
# * Copyright (c) 2016 everlaat
# * Licensed under the MIT license.
#

module.exports =
  activate: (state) ->
    arom.commands.add 'atom-workspace', "slugify:slugify", ->
      editor = atom.workspace.getActiveTextEditor()
      return unless editor?

      for selection in editor.getSelections()
        range = selection.getBufferRange()
        text = editor.getTextInBufferRange()
        newText = text.toString().toLowerCase()
                    .replace(/\s+/g, '-')           # Replace spaces with -
                    .replace(/[^\w\-]+/g, '')       # Remove all non-word chars
                    .replace(/\-\-+/g, '-')         # Replace multiple - with single -
                    .replace(/^-+/, '')             # Trim - from start of text
                    .replace(/-+$/, '')             # Trim - from end of text

        editor.setTextInBufferRange(range, newText)
