require "set"

N_MAX = 50

def convertCellPosDirToNextGroupDir(cellPos, cellDir)
  if cellDir == 2 || cellDir == 3 || cellDir == 5
    [0, 0]
  else
    [[1, 1], [0, 1], [-1, 0], [-1, -1], [0, -1], [1, 0]][(cellPos + (cellDir % 2)) % 6]
  end
end

def convertCellPosDirToDestinationCellPos(cellPos, cellDir)
  (cellPos + [2, 4, 1, 5, 3][cellDir]) % 6
end

def convertCellDirToDestinationCellDir(cellDir)
  [1, 0, 3, 2, 4][cellDir]
end

def solve(remarkableCellNum)
  cellNumCount = 0
  cellPos = 0
  cellDir = 1
  cellGroupPos = [N_MAX/2, N_MAX/2]
  cellGroupMap = Array.new(N_MAX){Array.new(N_MAX){Array.new(6){-1}}}
  cellGroupMap[cellGroupPos[0]][cellGroupPos[1]][0] = cellNumCount += 1
  
  arroundCellNums = Set.new
  until arroundCellNums.size == 5
    # 現在のセルポジション、セルディレクションをもとに
    # 次のセルポジション、セルディレクションを求める
    loop do
      cellDir = (cellDir + 4) % 5
      nextGroupDir = convertCellPosDirToNextGroupDir(cellPos, cellDir)
      groupPos = [cellGroupPos[0] + nextGroupDir[0], cellGroupPos[1] + nextGroupDir[1]]
      destinationPos = convertCellPosDirToDestinationCellPos(cellPos, cellDir)
      
      # 未訪問のセル（セルナンバーが負）を発見した場合そこに移動する
      if cellGroupMap[groupPos[0]][groupPos[1]][destinationPos] < 0
        cellGroupMap[groupPos[0]][groupPos[1]][destinationPos] = cellNumCount += 1
        cellPos = destinationPos
        cellGroupPos = groupPos
        cellDir = convertCellDirToDestinationCellDir(cellDir)
        break
      end
    end
    
    # 移動した先のセルポジション周りのセルナンバーを確認
    5.times{|i|
      nextGroupDir = convertCellPosDirToNextGroupDir(cellPos, i)
      groupPos = [cellGroupPos[0] + nextGroupDir[0], cellGroupPos[1] + nextGroupDir[1]]
      destinationPos = convertCellPosDirToDestinationCellPos(cellPos, i)
      cellNum = cellGroupMap[groupPos[0]][groupPos[1]][destinationPos]
      if cellNum >= 0 && cellNumCount == remarkableCellNum
        arroundCellNums.add(cellNum)
      elsif cellNum == remarkableCellNum
        arroundCellNums.add(cellNumCount)
      end
    }
  end
  arroundCellNums.to_a.sort*?,
end

puts solve(gets.to_i)