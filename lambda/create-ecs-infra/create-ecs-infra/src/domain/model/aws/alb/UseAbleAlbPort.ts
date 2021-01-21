// 連番の配列を作成
const createPortArray = (startPort: number, endPort: number) => {
  const arrayLength = endPort - startPort + 1
  return [...new Array(arrayLength).keys()].map((val) => val + startPort)
}

/*
  ALBとのHTTPSで利用できるポートを定義
  不足したらポートを足す
  443,
  10080 ~ 10089,
  10090 ~ 10099
*/
const useAblePortList = [
  ...createPortArray(10080, 10089),
  ...createPortArray(10090, 10099),
]

export { useAblePortList }
