function s:initialize()
    call s:defineVariableDefault('g:cnotes_notesRootDir'     , "")
    call s:defineVariableDefault('g:cnotes_codeRootDir'      , "")

    command! -nargs=0 -complete=command CNotesNewNote call cnotes#newNote()
    command! -nargs=0 -complete=command CNotesNewItem call cnotes#newNoteItemAt()
    command! -nargs=0 -complete=command CNotesNewReferenceItem call cnotes#newReferenceItemAt()
    command! -nargs=0 -complete=command CNotesNewLinkItem call cnotes#newLinkItem()
    command! -nargs=0 -complete=command CNotesOpenNote call cnotes#openNote()
    command! -nargs=0 -complete=command CNotesCreateNote call cnotes#createNote()
    command! -nargs=+ -complete=file CNotesSetRootDirs call cnotes#setRootDirs(<f-args>)
    command! -nargs=1 -complete=file CNotesSetNotesRoot call cnotes#setNotesRootDir(<f-args>)
    command! -nargs=1 -complete=file CNotesSetCodeRoot call cnotes#setCodeRootDir(<f-args>)
endfunction

function s:defineVariableDefault(name, default)
  if !exists(a:name)
    let {a:name} = a:default
  endif
endfunction

call s:initialize()
