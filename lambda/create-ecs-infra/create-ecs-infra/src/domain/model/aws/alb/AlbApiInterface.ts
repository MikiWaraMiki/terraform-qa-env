export interface AlbApiInterFace {
  getAlbArn(albName: string): Promise<string | undefined>
  getAlbUsingPortList(albArn: string): Promise<number[]>
}
