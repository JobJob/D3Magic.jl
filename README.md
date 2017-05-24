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
d3.select("g").text("Hello World");
</script>
"""
```
Hello There

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

### Another example
Show a graph:
```
d3"""
<g></g>

<style>
div.bar {
    display: inline-block;
    width: 20px;
    margin-right: 2px;
    background-color: teal;
}
</style>

<script>
var dataset = [ 5, 10, 13, 19, 21, 25, 22, 18, 15, 13,
                11, 12, 15, 20, 18, 17, 16, 18, 23, 25 ];

var bar_heights = dataset.map(function bar_height(d) { return 3*d })
d3.select("g").selectAll("div")
    .data(bar_heights)
    .enter()
    .append("div")
    .attr("class", "bar")
    .style("height", function(bar_height) {
        return bar_height + "px";
    })
    .style("margin-top", function(bar_height){
        return (100-bar_height)+"px"
    }) // surprisingly, this is needed to align the bottom of the bars
</script>
"""
```

![barplot example](images/barplot_example.png)
