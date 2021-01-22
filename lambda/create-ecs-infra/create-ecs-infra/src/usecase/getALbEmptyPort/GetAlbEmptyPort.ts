import { AlbApiInterFace } from '@/domain/model/aws/alb/AlbApiInterface'
import { UseAbleAlbPort } from '@/domain/model/aws/alb/UseAbleAlbPort'
import { createLambdaLogger } from '@/util/logger'

const getAlbEmptyPort = async (
  albApi: AlbApiInterFace,
  albName: string,
): Promise<number> => {
  const logger = createLambdaLogger()

  const albArn = await albApi.getAlbArn(albName)
  if (!albArn) {
    const errorMessage = `[GetAlbEmptyPort][getAlbEmptyPort] cannot find alb. check alb arn. alb_arn: ${albArn}`
    logger.log({
      level: 'info',
      message: errorMessage,
    })
    throw Error(errorMessage)
  }
  // ALBが利用しているポート一覧を取得する
  const albUsingPortList = await albApi.getAlbUsingPortList(albArn)

  logger.log({
    level: 'info',
    message: `using port list: ${albUsingPortList.join(',')}`,
  })

  const useAblePort = UseAbleAlbPort.useAblePort(albUsingPortList)
  if (!useAblePort) {
    const errorMessage =
      '[GetAlbEmptyPort][getAlbEmptyPort] usable port is limit.'
    logger.log({
      level: 'warn',
      message: errorMessage,
    })
    throw Error(errorMessage)
  }

  return useAblePort
}

export { getAlbEmptyPort }
