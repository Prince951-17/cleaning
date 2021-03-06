package dao

import com.google.inject.ImplementedBy
import com.typesafe.scalalogging.LazyLogging
import javax.inject.{Inject, Singleton}
import play.api.db.slick.{DatabaseConfigProvider, HasDatabaseConfigProvider}
import protocols.WorkerProtocol.Auth
import slick.jdbc.JdbcProfile

import scala.concurrent.Future


trait AuthorizeComponent { self: HasDatabaseConfigProvider[JdbcProfile] =>
  import utils.PostgresDriver.api._

  class AuthTable(tag: Tag) extends Table[Auth](tag, "Workers") {
    def login = column[String]("firstName")
    def password = column[String]("password")

    def * = (login, password) <> (Auth.tupled, Auth.unapply _)
  }
}

@ImplementedBy(classOf[AuthorizeDaoImpl])
trait AuthorizeDao {
  def getAuthor(customerData:Auth): Future[Option[Auth]]
}

@Singleton
class AuthorizeDaoImpl @Inject()(protected val dbConfigProvider: DatabaseConfigProvider)
  extends AuthorizeDao
    with AuthorizeComponent
    with HasDatabaseConfigProvider[JdbcProfile]
    with LazyLogging {

  import utils.PostgresDriver.api._

  val author = TableQuery[AuthTable]

  override def getAuthor(customerData:Auth): Future[Option[Auth]] = {
    db.run (author.filter(data => data.login === customerData.login && data.password === customerData.password).result.headOption)
  }

}
