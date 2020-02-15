
-module(update_all_files).

-export([doit/0]).

doit() ->
    F = fun(X) ->
                %remove "/docs/"
                %remove "https://github.com/zack-bitcoin/amoveo/blob/master/docs/"
                io:fwrite("removing substrings in "),
                io:fwrite(X),
                io:fwrite("\n"),
                S1 = <<"/docs/">>,
                S2 = <<"https://github.com/zack-bitcoin/amoveo/blob/master/docs/">>,
                {ok, Txt} = file:read_file(X),
                Txt2 = remove_substring(S2, Txt),
                Txt3 = remove_substring(S1, Txt2),
                file:write_file(X, Txt3)
        end,
                
    recursive_folders(".", F).

remove_substring(Pattern, B) ->
    S = 8*size(Pattern),
    <<P:S>> = Pattern,
    remove_substring2(P, S, B, <<>>).
remove_substring2(P, S, B, T) ->
    case B of
        <<P:S, Rest/binary>> ->
            remove_substring2(P, S, Rest, T);
        <<A, Rest/binary>> ->
            remove_substring2(P, S, Rest, <<T/binary, A>>);
        <<>> -> T
    end.
            

recursive_folders(Dir, F) ->
    {ok, L} = file:list_dir(Dir),
    recursive_folders2(Dir, L, F).

recursive_folders2(_, [], _) -> ok;
recursive_folders2(Dir, [H|T], F) ->
    Loc = Dir ++ "/" ++ H,
    Length = length(Loc),
    case file:list_dir(Loc) of
        {error, enoent} ->
            io:fwrite("this should never happen.");
        {error, enotdir} -> 
            {_, Type} = lists:split(Length-3, Loc),
            case Type of
                ".md" ->
                    F(Loc);
                _ -> ok
            end;
        {ok, L} ->
            recursive_folders2(Loc, L, F)
    end,
    recursive_folders2(Dir, T, F).
           
