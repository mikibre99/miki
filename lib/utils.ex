defmodule Utils do
    def trim_text(text, length) do
        string_length = String.length(text)
        if string_length > length do
            range = 0..length
            String.slice(text, range) <> " ..."
        else
            text
        end
    end
end