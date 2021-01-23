/**
 * TargetGroupのヘルスチェック設定
 */
export class HealthCheckSetting {
  private healthCheckEnabled: boolean = true
  private healthCheckPath: string
  private healthCheckProtocol: AwsTargetGroupHealthCheckProtocol
  private healthCheckPort: string

  /**
   * コンストラクタ
   * @param healthCheckPath ヘルスチェック時のパス
   * @param healthCheckProtocol ヘルスチェック時のプロトコル
   * @param healthCheckPort ヘルスチェック時のポート
   */
  constructor(
    healthCheckPath: string,
    healthCheckProtocol: AwsTargetGroupHealthCheckProtocol,
    healthCheckPort: string,
  ) {
    this.healthCheckPath = healthCheckPath
    this.healthCheckProtocol = healthCheckProtocol
    this.healthCheckPort = healthCheckPort
  }

  /**
   * healthCheckを無効化する
   */
  disableHealthCheck() {
    this.healthCheckEnabled = false
  }

  /**
   * AWS SDKのリクエストパラメータ
   * TODO: インフラ層に移行する
   */
  get awsApiRequestParams() {
    return {
      HealthCheckEnabled: this.healthCheckEnabled,
      HealthCheckPath: this.healthCheckPath,
      HealthCheckProtocol: this.healthCheckProtocol,
      HealthCheckPort: this.healthCheckPort,
    }
  }
}
