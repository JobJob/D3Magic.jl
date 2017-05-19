module D3Magic

# ported from https://github.com/ResidentMario/py_d3

export @d3_str

const d3id = Ref(0)
d3version = "3.5.2"

setD3version(version) = global d3version = version

function d3string(userd3code)
    id = (d3id[] += 1)
    userd3code = replace(userd3code, r"d3.select\((?!this)", "d3.select$id(")
    userd3code = replace(userd3code, r"d3.selectAll\((?!this)", "d3.selectAll$id(")
    """
    <g id="d3-cell-$id">
        <script>
            requirejs.config({
                paths: {
                    d3: "//cdnjs.cloudflare.com/ajax/libs/d3/$d3version/d3"
                }
            });
            require(['d3'], function(d3) {
                window.d3 = d3;
                d3.select$id = function(selection) {
                    return d3.select("#d3-cell-$id").select(selection);
                }
                d3.selectAll$id = function(selection) {
                    return d3.select("#d3-cell-$id").selectAll(selection);
                }
            });
        </script>
        $userd3code
    </g>
    """
end

macro d3_str(s)
    display("text/html", d3string(s))
end

end