function s:checkRootDirs()
    if !exists('g:cnotes_notesRootDir') || strlen(g:cnotes_notesRootDir) == 0
        echomsg "Please set notes root directory first."
        return 0
    endif

    if !isdirectory(g:cnotes_notesRootDir)
        echomsg g:cnotes_notesRootDir . " is not a directory for notes."
        return 0
    endif

    if !exists('g:cnotes_codeRootDir') || strlen(g:cnotes_codeRootDir) == 0
        echomsg "Please set code root directory first."
        return 0
    endif

    if !isdirectory(g:cnotes_codeRootDir)
        echomsg g:cnotes_codeRootDir . " is not a directory for code."
        return 0
    endif

    return 1
endfunction

function s:getCodeRelativePath()
    let l:ret = s:checkRootDirs()
    if !l:ret
        return ""
    endif

    let l:code_file = expand('%:p')
    if stridx(l:code_file, g:cnotes_codeRootDir) < 0
        echomsg "Wrong code root directory:" . g:cnotes_codeRootDir
        return ""
    endif

    let l:count = strlen(g:cnotes_codeRootDir)
    if strpart(g:cnotes_codeRootDir, l:count - 1, 1) != '/'
        let l:count = l:count + 1
    endif

    let l:relative_path = strpart(l:code_file, l:count)
    return l:relative_path
endfunction

function s:getNotePath()
    let l:relative_path = s:getCodeRelativePath()
    let l:count = strlen(g:cnotes_notesRootDir)
    let l:note_path = g:cnotes_notesRootDir
    if strpart(g:cnotes_notesRootDir, l:count - 1, 1) != '/'
        let l:note_path = l:note_path . '/'
    endif
    let l:note_path = l:note_path . l:relative_path

    return l:note_path
endfunction

function cnotes#newNote()
    let l:file_path = s:getCodeRelativePath()
    let @a =      "{\n"
    let @a = @a . "  \"file\":\"" . l:file_path . "\",\n"
    let @a = @a . "  \"author\":\"\",\n"
    let @a = @a . "  \"created_at\":\"\",\n"
    let @a = @a . "  \"last_modify\":\"\",\n"
    let @a = @a . "  \"notes\":[\n"
    let @a = @a . "  ]\n"
    let @a = @a . "},\n"
endfunction

function cnotes#newNoteItemAt()
    let l:cur_pos = getpos(".")
    let l:line_num = l:cur_pos[1]
    let l:col_num = l:cur_pos[2]

    let l:tag_name = ""
    if exists(':TagbarToggle')
        let l:tag_name = tagbar#currenttag("%s", "")
    endif

    let @a =      "    {\n"
    let @a = @a . "      \"line\":"   . l:line_num . ",\n"
    let @a = @a . "      \"column\":" . l:col_num  . ",\n"
    if strlen(l:tag_name) > 0
    let @a = @a . "      \"tag\":\""  . l:tag_name . "\",\n"
    endif
    let @a = @a . "      \"type\":\"note\",\n"
    let @a = @a . "      \"comment\":\"\",\n"
    let @a = @a . "      \"references\":[\n"
    let @a = @a . "      ],\n"
    let @a = @a . "      \"links\":[\n"
    let @a = @a . "      ]\n"
    let @a = @a . "    },\n"
endfunction

function cnotes#newReferenceItemAt()
    let l:cur_pos = getpos(".")
    let l:line_num = l:cur_pos[1]
    let l:col_num = l:cur_pos[2]

    let l:tag_name = ""
    if exists(':TagbarToggle')
        let l:tag_name = tagbar#currenttag("%s", "")
    endif

    let l:file_path = s:getCodeRelativePath()

    let @a =      "        {\n"
    let @a = @a . "          \"file\":\"" . l:file_path . "\",\n"
    let @a = @a . "          \"line\":"   . l:line_num  . ",\n"
    let @a = @a . "          \"column\":" . l:col_num   . ",\n"
    if strlen(l:tag_name) > 0
    let @a = @a . "          \"tag\":\""  . l:tag_name  . "\"\n"
    endif
    let @a = @a . "        },\n"
endfunction

function cnotes#newLinkItem()
    let @a =      "        {\n"
    let @a = @a . "          \"label\":\"\",\n"
    let @a = @a . "          \"url\":\"\",\n"
    let @a = @a . "          \"author\":\"\",\n"
    let @a = @a . "          \"details\":\"\"\n"
    let @a = @a . "        },\n"
endfunction

function cnotes#setNotesRootDir(notesRoot)
    let g:cnotes_notesRootDir = a:notesRoot
endfunction

function cnotes#setCodeRootDir(codeRoot)
    let g:cnotes_codeRootDir = a:codeRoot
endfunction

function cnotes#setRootDirs(notesRoot, codeRoot)
    call cnotes#setNotesRootDir(a:notesRoot)
    call cnotes#setCodeRootDir(a:codeRoot)
endfunction

function cnotes#openNote()
    let l:note_path = s:getNotePath()

    let l:note_path_no_ext = fnamemodify(l:note_path, ':p:r')
    let l:note_path = l:note_path_no_ext . ".json"

    if !filereadable(l:note_path)
        echomsg "Note doesn't exist, need to create it first. " . l:note_path
        return
    endif

    "echo l:note_path
    execute '50vsplit ' . l:note_path
    execute 'setlocal wrap'
endfunction

function cnotes#createNote()
    let l:note_path = s:getNotePath()

    let l:note_path_no_ext = fnamemodify(l:note_path, ':p:r')
    let l:note_path = l:note_path_no_ext . ".json"
    if filereadable(l:note_path)
        echomsg "Note already exists: " . l:note_path
    else
        let l:base_dir = fnamemodify(l:note_path, ':p:h')
        if !isdirectory(l:base_dir)
            mkdir(l:base_dir, 'p')
        endif
    endif

    "echo l:note_path
    execute '50vsplit ' . l:note_path
    execute 'setlocal wrap'
endfunction
