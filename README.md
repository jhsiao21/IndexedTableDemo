# IndexedTableDemo
**Adding an index for UITableView with multiple sections.**  
  
重點: 
* 有時加上索引A~Z索引清單後，會有索引數大於原先區塊數  

```code
  //解決索引數量大於區塊數量，並清楚告訴表格視圖特定索引按下去後的區塊數
    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        
        guard let index = animalSectionTitles.index(of: title) else {
            return -1
        }
        
        return index
    }
```
