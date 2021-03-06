package actors

import com.google.inject.AbstractModule
import play.api.libs.concurrent.AkkaGuiceSupport

class ActorsModule extends AbstractModule with AkkaGuiceSupport {
  override def configure() = {
    bindActor[WorkerManager]("worker-manager")
    bindActor[OrderManager]("order-manager")
    bindActor[GenderManager]("gender-manager")
    bindActor[EducationManager]("education-manager")
    bindActor[AuthorizeManager]("authorize-manager")
  }
}
