#
# * atom-slugify
# * https://github.com/everlaat/atom-slugify
# *
# * Copyright (c) 2016 everlaat
# * Licensed under the MIT license.
#

module.exports =
  activate: (state) ->
    atom.commands.add 'atom-workspace', "slugify:create-slug-from-selected-text", => @convert()

  convert: ->
    editor = atom.workspace.getActiveTextEditor()
    return unless editor?

    buffer = editor.getBuffer()
    selections = editor.getSelections()

    # Group these actions so they can be undone together
    buffer.transact ->
      for selection in selections
        text = selection.getText()
        newText = text.toString().toLowerCase()
                    .replace(/\s+/g, '-')           # Replace spaces with -
                    .replace(/[^\w\-]+/g, '')       # Remove all non-word chars
                    .replace(/\-\-+/g, '-')         # Replace multiple - with single -
                    .replace(/^-+/, '')             # Trim - from start of text
                    .replace(/-+$/, '')             # Trim - from end of text
        selection.insertText("#{newText}")
