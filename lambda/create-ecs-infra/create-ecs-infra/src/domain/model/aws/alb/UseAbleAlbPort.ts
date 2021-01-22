/**
 * ALBで利用できるポートオブジェクト
 * staticで指定したポート範囲しか使わない
 * ポートが不足した場合には、createPortArrayを利用して、ポート範囲を追加する
 */
export class UseAbleAlbPort {
  /**
   * 利用できるポートの一覧を返す
   * 10080 ~ 10089
   * 10090 ~ 10099
   */
  static useAblePortList(): number[] {
    // ポートの連番配列を作成する
    const portArrayGenerator = (
      startPort: number,
      endPort: number,
    ): number[] => {
      const arrayLength = endPort - startPort + 1
      return [...new Array(arrayLength).keys()].map((val) => val + startPort)
    }
    return [
      ...portArrayGenerator(10080, 10089),
      ...portArrayGenerator(10090, 10099),
    ]
  }

  /**
   * 利用できるポートを返す
   * @param alreadyUsedPortList すでに利用しているポート一覧
   */
  static useAblePort(alreadyUsedPortList: number[]): number | undefined {
    const portList = UseAbleAlbPort.useAblePortList().filter((port) => {
      return !alreadyUsedPortList.includes(port)
    })
    if (portList.length < 1) return undefined
    return portList[0]
  }
}
