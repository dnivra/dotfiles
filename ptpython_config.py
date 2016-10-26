"""
Configuration file for ptpython.
"""

from __future__ import unicode_literals
from prompt_toolkit.keys import Keys

__all__ = (
    'configure',
)


def configure(repl):
    repl.confirm_exit = False
    repl.enable_auto_suggest = True
    repl.enable_mouse_support = False
    repl.enable_open_in_editor = True
    repl.highlight_matching_parenthesis = True
    repl.insert_blank_line_after_output = False
    repl.true_color = True
    repl.use_code_colorscheme('fruity')
    repl.vi_mode = True
    repl.wrap_lines = True

    corrections = {
        'impotr': 'import',
        'pritn': 'print',
    }

    # When a space is pressed. Check & correct word before cursor.
    @repl.add_key_binding(' ')
    def CorrectLastWord(event):
        b = event.cli.current_buffer
        w = b.document.get_word_before_cursor()
        if w is not None:
            if w in corrections:
                b.delete_before_cursor(count=len(w))
                b.insert_text(corrections[w])

        b.insert_text(' ')

    # Ctrl+Left: move to previous word beginning
    @repl.add_key_binding(Keys.ControlLeft)
    def CtrlLeft(event):
        buffer = event.current_buffer
        pos = buffer.document.find_previous_word_beginning(count=event.arg)
        if pos:
            buffer.cursor_position += pos

    # Ctrl+Right: move to next word ending
    @repl.add_key_binding(Keys.ControlRight)
    def CtrlRight(event):
        buffer = event.current_buffer
        pos = buffer.document.find_next_word_ending(count=event.arg)
        if pos:
            buffer.cursor_position += pos
