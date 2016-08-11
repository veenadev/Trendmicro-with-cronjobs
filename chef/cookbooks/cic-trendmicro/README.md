# cic-trendmicro-cookbook

TODO: The cookbook installs Trend Micro's Deep security agent

## Supported Platforms

TODO: List your supported platforms.

* Ubuntu - (12.04+)
* Centos - (6.0+)

## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['cic-trendmicro']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>

## Usage

### cic-trendmicro::default

Include `cic-trendmicro` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[cic-trendmicro::default]"
  ]
}
```

## License and Authors

Author:: Shubham Dhoka (<shubham.dhoka@reancloud.com>)
