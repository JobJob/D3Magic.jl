module D3Magic

# ported from https://github.com/ResidentMario/py_d3

export @d3_str, display_d3, d3update_display, cur_cell

const d3id = Ref(0)
d3version = "4.9.1"

setD3version(version::String) = global d3version = version

function d3code_with_id(userd3code, id)
    userd3code = replace(userd3code, r"d3.select\((?!this)", "d3.select$id(")
    return replace(userd3code, r"d3.selectAll\((?!this)", "d3.selectAll$id(")
end

function d3string(userd3code, id)
    userd3code = d3code_with_id(userd3code, id)
    """
    <g id="d3-cell-$id">
        <script>
            d3.select$id = function(selection) {
                return d3.select("#d3-cell-$id").select(selection);
            }
            d3.selectAll$id = function(selection) {
                return d3.select("#d3-cell-$id").selectAll(selection);
            }
            d3._select = d3.select
            d3._selectAll = d3.selectAll
        </script>
        $userd3code
    </g>
    """
end

d3update_string(userd3code, id) = d3code_with_id(userd3code, id)

macro d3_str(sraw)
    s = parse(string("\"\"\"", sraw, "\"\"\""))
    quote
        display_d3($(esc(s)))
    end
end

function display_d3(s, id = (d3id[] += 1))
    display("text/html", d3string(s, id))
end

function d3update_display(s, id = d3id[])
    display("text/html", d3update_string(s, id))
end

cur_cell() = d3id[]

function __init__()
    display("text/html","""<script>
        requirejs.config({
            paths: {
                d3: "//cdnjs.cloudflare.com/ajax/libs/d3/$d3version/d3"
            }
        });
        require(['d3'], function(d3) {
            window.d3 = d3;
        })
    </script>""")
end

end #module
