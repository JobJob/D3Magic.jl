## D3Magic

Port of https://github.com/ResidentMario/py_d3 to allow you to run D3 code in
IJulia/Jupyter notebooks

### Installation

Not registered (yet) so:
`Pkg.clone("https://github.com/JobJob/D3Magic.jl.git")`

Also if you add this to you custom.js - mine is in `~/.jupyter/custom/custom.js` you can get proper html highlighting:
```
require(["notebook/js/codecell"], function(codecell) {
    codecell.CodeCell.options_default.highlight_modes["text/html"] = {"reg":[/^d3/]}
})
```

### Usage
```
d3"""
<g></g>

<script>
d3.select("g").text("Hello World");
</script>
"""
```
Hello There

Show a graph:
```
d3"""
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

<script>
var dataset = [ 5, 10, 13, 19, 21, 25, 22, 18, 15, 13,
                11, 12, 15, 20, 18, 17, 16, 18, 23, 25 ];

d3.select("g").selectAll("div")
    .data(dataset)
    .enter()
    .append("div")
    .attr("class", "bar")
    .style("height", function(d) {
        var barHeight = d * 5;
        return barHeight + "px";
    });
</script>
"""
```
![](images/example_graph.png)
