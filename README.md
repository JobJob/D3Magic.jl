## D3Magic

Allows you to run D3 code in IJulia/Jupyter notebooks. Largely a port of https://github.com/ResidentMario/py_d3

### Installation

Not registered (yet) so:
`Pkg.clone("https://github.com/JobJob/D3Magic.jl.git")`

### Basic Usage

```
d3"""
<g></g>

<script>
d3.select("g").text("Hello There");
</script>
"""
```
displays:
```
Hello There
```
### Syntax Highlighting

If you add this to your custom.js - mine is in `~/.jupyter/custom/custom.js` you can get proper html highlighting:
```
require(["notebook/js/codecell"], function(codecell) {
    codecell.CodeCell.options_default.highlight_modes["text/html"] = {"reg":[/^d3/]}
})
```

### D3 version

This uses D3 version 4.9.1 by default. You can use a different version by calling, e.g.,
`D3Magic.setD3version("3.5.11")`

### Limitations

Most of the quirks [mentioned here](https://github.com/ResidentMario/py_d3#porting) and [here](https://github.com/ResidentMario/py_d3#technicals), and probably a few more to boot, also apply to this package.

### Usage with Interact/InteractNext etc

Some things to note about this example:

* uses the (slightly) lower level `display_d3` function
* uses `d3update_display` so selections select elements created in the previous call to `display_d3`
* interpolates a julia array into the javascript with
```js
var dataset = $(jl_dataset[1:n])
```

Show a graph:
```julia
display_d3("""
    <g></g>

    <style>
    element {
        height: 25px;
    }
    div.bar {
        display: inline-block;
        width: 20px;
        height: 75px;
        margin-right: 2px;
        background-color: teal;
    }
    </style>
""")

@manipulate for h in 1:30, i in slider(1:20, value=5, label="i"), n in 1:20
    jl_dataset = [5, 10, 13, 19, 21, 10, 22, 18, 15, 13,
                   11, 12, 15, 20, 18, 17, 16, 18, 23, 25]
    jl_dataset[i] = h

    d3update_display("""
        <script>
        var dataset = $(jl_dataset[1:n])

        d3.select("g").selectAll("div")
            .data(dataset)
            .enter()
            .append("div")

        d3.select("g").selectAll("div")
            .data(dataset)
            .exit()
            .remove()

        d3.select("g").selectAll("div")
            .data(dataset)
            .attr("class", "bar")
            .style("height", function(d) {
                var barHeight = d * 5;
                return barHeight + "px";
            });
        </script>
    """)
end;
```

![barplot example](images/barplot_example.png)
