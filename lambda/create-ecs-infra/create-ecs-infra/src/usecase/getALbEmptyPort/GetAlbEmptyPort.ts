import { AlbApiInterFace } from '@/domain/model/aws/alb/AlbApiInterface'
import { useAblePortList } from '@/domain/model/aws/alb/UseAbleAlbPort'
import { createLambdaLogger } from '@/util/logger'

const getAlbEmptyPort = async (
  albApi: AlbApiInterFace,
  albName: string,
): Promise<number> => {
  const logger = createLambdaLogger()
  const albArn = await albApi.getAlbArn(albName)
  if (!albArn) {
    logger.log({
      level: 'info',
      message: '[GetAlbEmptyPort][getAlbEmptyPort]albArn is undefined',
    })
    throw Error('[GetAlbEmptyPort][getAlbEmptyPort]albArn is undefined')
  }
  const albUsingPortList = await albApi.getAlbUsingPortList(albArn)

  logger.log({
    level: 'info',
    message: `using port list: ${albUsingPortList.join(',')}`,
  })

  const useAbleEmptyPortList = useAblePortList.filter((port) => {
    return !albUsingPortList.includes(port)
  })

  logger.log({
    level: 'info',
    message: `empty port list: ${useAbleEmptyPortList.join(',')}`,
  })
  if (useAbleEmptyPortList.length < 1) {
    logger.log({
      level: 'warn',
      message: `[GetAlbEmptyPort][getAlbEmptyPort] empty port is not exist... usingPort:${albUsingPortList.join(
        ',',
      )}`,
    })
    throw Error('[GetAlbEmptyPort][getAlbEmptyPort] empty port is not exist...')
  }

  return useAbleEmptyPortList[0]
}

export { getAlbEmptyPort }
